//
//  ProfileService.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

import RxCocoa
import RxSwift

final class ProfileService {
    let baseURL = URLConstant.baseURL
    var accessToken = UserDefaults.standard.string(forKey: Constant.UserDefaults.token)!
    
    func requestProfile() throws -> Observable<Profile> {
        let url = URL(string: baseURL + Endpoint.profile)!
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.get
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.rx.response(request: request)
            .map { [weak self] _, data in
                guard let result = Profile.parse(data: data) else {
                    print("Parsing Error")
                    return Profile(user: User(photo: "", email: "", username: ""))
                }
                
                return result
            }
    }
}
