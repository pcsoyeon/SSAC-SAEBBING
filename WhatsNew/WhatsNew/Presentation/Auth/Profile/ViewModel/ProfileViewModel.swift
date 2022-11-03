//
//  ProfileViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

enum NetworkResult {
  case success(Profile)
  case error(ProfileError)
}

enum ProfileError: Int, Error {
  case badRequest = 400
  case authenticationFailed = 401
  case notFoundException = 404
  case contentLengthError = 413
  case quotaExceeded = 429
  case systemError = 500
  case endpointError = 503
  case timeout = 504
}

final class ProfileViewModel {
    var profile = BehaviorRelay<Profile>(value: Profile(user: User(photo: "", email: "", username: "")))
    
    var name = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    var userImageURL = PublishRelay<String>()
    
    func requestProfile() {
        let api = AuthAPI.profile
        
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { [weak self] response in
                guard let self = self else { return }

                switch response.result {
                case .success(let data):
                    self.name.accept(data.user.username)
                    self.email.accept(data.user.email)
                    self.userImageURL.accept(data.user.photo)

                case .failure(let error):
                    print(error)
                    self.name.accept("유저 이름 정보가 없습니다.")
                    self.email.accept("유저 이메일 정보가 없습니다.")
                    self.userImageURL.accept("")
                }
            }
    }
    
    func request() -> Single<NetworkResult> {
        let api = AuthAPI.profile
        let request = AF.request(api.url, method: .get, headers: api.headers)
        
        return Single.create { single in
            request
                .responseData { [weak self] response in
                    guard let self = self else { return }
                    
                    switch response.result {
                    case let .success(jsonData):
                        do {
                            let returnObject = try JSONDecoder().decode(Profile.self, from: jsonData)
                            single(.success(.success(returnObject)))
                            
                            self.email.accept(returnObject.user.email)
                            self.name.accept(returnObject.user.username)
                            self.userImageURL.accept(returnObject.user.photo)
                            
                        } catch let error {
//                            single(.error(error))
                        }
                        
                    case let .failure(error):
                        if let statusCode = response.response?.statusCode {
                            if let networkError = ProfileError(rawValue: statusCode){
                                single(.success(.error(networkError)))
                            }
                        }
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
