//
//  SigninViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class SigninViewModel {
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(email, password)
            .map { email, password in
                print(email, password)
                return email.count > 0 && email.contains("@") && email.contains(".") && password.count > 7
            }
    }
    
    var isSucceed = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let signinTap: ControlEvent<Void>
    }
    
    struct Output {
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        let signinTap: ControlEvent<Void>
        
        let isSucceed: BehaviorRelay<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let emailText = input.emailText.orEmpty
        let passwordText = input.passwordText.orEmpty
        
        return Output(emailText: emailText,
                      passwordText: passwordText,
                      signinTap: input.signinTap,
                      isSucceed: isSucceed)
    }
    
    func requestSignin() {
        let api = AuthAPI.login(email: email.value, password: password.value)
        
//        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
//            .validate(statusCode: 200...299)
//            .responseDecodable(of: Signin.self) { [weak self] response in
//                guard let self = self else { return }
//
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let value = response.value else { return }
//
//                switch response.result {
//                case .success:
//
//                    switch statusCode {
//                    case 200..<300:
//                        UserDefaults.standard.set(value.token, forKey: "token")
//                        self.isSucceed.accept(true)
//                    default:
//                        self.isSucceed.accept(false)
//                    }
//
//                case .failure(_):
//                    print("Error - \(statusCode)")
//                }
//            }
        
        AF.request(AuthRouter.signin(email: "12@test.com", password: "09876543"))
            .validate(statusCode: 200...299)
            .responseDecodable(of: Signin.self) { [weak self] response in
                guard let self = self else { return }
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                switch response.result {
                case .success:
                    
                    switch statusCode {
                    case 200..<300:
                        UserDefaults.standard.set(value.token, forKey: "token")
                        self.isSucceed.accept(true)
                    default:
                        self.isSucceed.accept(false)
                    }
                    
                case .failure(_):
                    print("Error - \(statusCode)")
                }
            }
    }
}
