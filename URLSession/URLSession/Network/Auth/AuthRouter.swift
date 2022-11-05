//
//  AuthRouter.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

enum AuthRouter {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension AuthRouter {
    
    private enum Query: String {
        case userName
        case email
        case password
    }
    
    var baseURL: String {
        return URLConstant.baseURL
    }
    
    var urlString: String {
        switch self {
        case .signup:
            return URLConstant.baseURL + Endpoint.signup
        case .login:
            return URLConstant.baseURL + Endpoint.login
        case .profile:
            return URLConstant.baseURL + Endpoint.profile
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .signup(let userName, let email,let password):
            return [
                URLQueryItem(name: Query.userName.rawValue, value: userName),
                URLQueryItem(name: Query.email.rawValue, value: email),
                URLQueryItem(name: Query.password.rawValue, value: password)
            ]
        case .login(let email, let password):
            return [
                URLQueryItem(name: Query.email.rawValue, value: email),
                URLQueryItem(name: Query.password.rawValue, value: password)
            ]
        default: return [URLQueryItem(name: "", value: "")]
        }
    }
    
}
