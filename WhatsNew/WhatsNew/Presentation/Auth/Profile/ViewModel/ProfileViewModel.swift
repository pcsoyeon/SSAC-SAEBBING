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
    
    func requestProfile() {
        let api = AuthAPI.profile
        
        AF.request(api.url, method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let data):
                    self.name.accept(data.user.username)
                    self.email.accept(data.user.email)
                    
                case .failure(let error):
                    print(response.response?.statusCode)
                }
            }
    }
}
