//
//  LoginViewModel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

final class LoginViewModel {
    
    // MARK: - Property
    
    private var email = BehaviorRelay<String>(value: "")
    private var password = BehaviorRelay<String>(value: "")
    
    private var isLoginSucceed = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Input/Output
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let loginTap: ControlEvent<Void>
    }
    
    struct Output {
        let loginTap: Driver<Void>
        
        let validation: Observable<Bool>
        let isLoginSucceed: PublishSubject<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let tap = input.loginTap.asDriver()
        
        let emailValid = input.emailText.orEmpty
            .map { $0.count > 0 && $0.contains("@") && $0.contains(".") }
        
        let passwordValid = input.passwordText.orEmpty
            .map { $0.count >= 8 }
        
        let validation = Observable.combineLatest( emailValid, passwordValid)
            .map { $0 && $1 }
            .share()
        
        input.emailText.orEmpty
            .withUnretained(self)
            .bind { vm, value in
                vm.email.accept(value)
            }
            .disposed(by: disposeBag)
        
        input.passwordText.orEmpty
            .withUnretained(self)
            .bind { vm, value in
                vm.password.accept(value)
            }
            .disposed(by: disposeBag)
        
        return Output(loginTap: tap, validation: validation, isLoginSucceed: isLoginSucceed)
    }
    
    func requestLogin() {
        
    }
}
