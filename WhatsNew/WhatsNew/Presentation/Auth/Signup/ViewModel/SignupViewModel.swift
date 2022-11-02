//
//  SignupViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class SignupViewModel {
    
    // MARK: - Relay Property
    
    var userName = BehaviorRelay<String>(value: "닉네임을 입력해주세요")
    var email = BehaviorRelay<String>(value: "이메일을 입력해주세요")
    var password = BehaviorRelay<String>(value: "비밀번호를 입력해주세요")
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(email, password)
            .map { email, password in
                print(email, password)
                return email.count > 0 && email.contains("@") && email.contains(".") && password.count > 7
            }
    }
    
    var isSucceed = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Request Method
    
    func requestSignin() {
        let api = AuthAPI.signup(userName: userName.value,
                                 email: email.value,
                                 password: password.value)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 200..<300:
                    self.isSucceed.onNext(true)
                case 400..<500:
                    self.isSucceed.onError(NetworkError.badRequest)
                case 500..<600:
                    self.isSucceed.onError(NetworkError.serverError)
                default:
                    self.isSucceed.onError(NetworkError.networkFail)
                }
                
            case .failure:
                print("error")
            }
        }
    }
}
