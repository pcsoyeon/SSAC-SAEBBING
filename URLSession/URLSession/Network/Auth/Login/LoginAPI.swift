//
//  LoginAPI.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

final class LoginAPI {
    
    static let shared = LoginAPI()
    
    private init() { }
    
    func requestLogin(email: String, password: String) {
        let urlString = "http://api.memolease.com/api/v1/users/login"
        let url = URL(string: urlString)
        
        var urlRequest = URLRequest(url: url!)

        let formData: [String : String] = ["email": email,
                                           "password": password]
        let formDataString = (formData.compactMap({ (key, value) -> String in
          return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
            
        let formEncodedData = formDataString.data(using: .utf8)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = formEncodedData
        urlRequest.setValue("application/x-www-form-urlencoded",
                            forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {

                guard error == nil else {
                    print("Failed Request")
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Login.self, from: data)
                    print(result.token)
                    
                } catch let error {
                    print(error)
                }
                
            }
            
        })
        
        task.resume()
    }
    
}
