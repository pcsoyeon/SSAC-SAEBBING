//
//  AuthRouter.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import Alamofire

enum AuthRouter: URLRequestConvertible {
    case login(email: String, password: String)
}

extension AuthRouter {
    var baseURL: URL {
        return URL(string: "http://api.memolease.com/api/v1/users")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type" : "application/x-www-form-urlencoded"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .login(let email, let password):
            return [
                "email" : email,
                "password" : password
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        print(url)
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        switch self {
        case .login:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}
