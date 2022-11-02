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
}
