//
//  LoginViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/28.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

enum LoginError: Error {
    case badRequest
    case serverError
}

final class LoginViewModel {
    let emailRelay = BehaviorRelay<String>(value: "이메일을 입력해주세요")
    let passwordRelay = BehaviorRelay<String>(value: "비밀번호를 입력해주세요")
    
    var isLoginSucceed = PublishSubject<LoginResponse>()
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(emailRelay, passwordRelay)
            .map { email, password in
                print("Email : \(email), Password : \(password)")
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0 && !password.isEmpty 
            }
    }
    
    func requestLogin(_ loginRequest: LoginRequest) {
        let url = ""
        let headers : HTTPHeaders = ["Content-Type" : "application/json"]
        let params: Parameters = ["email": loginRequest.email, "password" : loginRequest.password]
        
        let request = AF.request(url,
                                 method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        request.responseDecodable(of: LoginResponse.self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                
                guard let statusCode = response.response?.statusCode else { return }
                
                if statusCode == 200 {
                    self.isLoginSucceed.onNext(value)
                } else if statusCode == 400 {
                    self.isLoginSucceed.onError(LoginError.badRequest)
                } else if statusCode  == 500 {
                    self.isLoginSucceed.onError(LoginError.serverError)
                }
                
            case .failure(let error):
                self.isLoginSucceed.onError(LoginError.badRequest)
                print(error)
            }
        }
    }
}
