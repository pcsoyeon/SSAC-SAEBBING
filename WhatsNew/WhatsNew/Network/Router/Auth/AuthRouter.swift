//
//  AuthRouter.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import Alamofire

enum AuthRouter: URLRequestConvertible {
    case signup(userName: String, email: String, password: String)
    case signin(email: String, password: String)
    case profile
}

extension AuthRouter {
    var baseURL: URL {
        return URL(string: URLConstant.authBaseURL)!
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .signin:
            return "/login"
        case .profile:
            return "/me"
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .signup, .signin:
            return ["Content-Type" : "application/x-www-form-urlencoded"]
        case .profile:
            return ["Authorization" : "Bearer \(APIKey.token)"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup, .signin:
            return .post
        case .profile:
            return .get
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName" : userName,
                "email" : email,
                "password" : password
            ]
        case .signin(let email, let password):
            return [
                "email" : email,
                "password" : password
            ]
        case .profile:
            return ["":""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        print(url)
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        switch self {
        case .signin, .signup:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case .profile:
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
}
