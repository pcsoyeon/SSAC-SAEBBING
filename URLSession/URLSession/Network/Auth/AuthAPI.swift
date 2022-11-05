//
//  SigninAPI.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

final class AuthAPI {
    
    static let shared = AuthAPI()
    
    private init() { }
    
    private let session = URLSession.shared
    
    func requestSignup(userName: String, email: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        
        let api = AuthRouter.signup(userName: userName,
                                    email: email,
                                    password: password)
        
        guard let url = URL(string: api.urlString) else { return }
        
        var component = URLComponents()
        component.queryItems = api.parameters
        let body = component.query?.data(using: .utf8)
        
        let request = createRequest(of: url, httpMethod: HTTPMethod.post, with: api.headers, with: body)
        
        session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.failedRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard data != nil else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success("ok"))
            
        }.resume()
    }
}

extension AuthAPI: RequestProtocol {
    func createRequest(of url: URL, httpMethod: String, with headers: [String : String]?, with body: Data?) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        
        headers?.forEach({ header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        })
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
}
