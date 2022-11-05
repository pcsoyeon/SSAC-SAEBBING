//
//  SignupViewModel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/04.
//

import Foundation

import RxCocoa
import RxSwift

final class SignupViewModel: BaseViewModel {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var name = BehaviorRelay<String>(value: "")
    private var email = BehaviorRelay<String>(value: "")
    private var password = BehaviorRelay<String>(value: "")
    
    private var isSignupSucceed = PublishSubject<Bool>()
    
    // MARK: - Input/Output
    
    struct Input {
        let nameText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
        let isSignupSucceed: PublishSubject<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let nameValid = input.nameText.orEmpty
            .map { $0.count > 0 && $0.count <= 12 && !$0.isEmpty }
            .share()
        
        let emailValid = input.emailText.orEmpty
            .map { $0.count > 0 && $0.contains("@") && $0.contains(".") }
            .share()
        
        let passwordValid = input.passwordText.orEmpty
            .map { $0.count >= 8 }
            .share()
        
        let totalValid = Observable.combineLatest(nameValid, emailValid, passwordValid)
            .map { $0 && $1 && $2 }
            .share()
        
        input.nameText
            .orEmpty
            .withUnretained(self)
            .bind { vm, value in
                vm.name.accept(value)
            }
            .disposed(by: disposeBag)
        
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
        
        return Output(validation: totalValid, tap: input.tap, isSignupSucceed: isSignupSucceed)
    }
    
    func requestSignup() {
        AuthAPI.shared.requestSignup(userName: name.value,
                                     email: email.value,
                                     password: password.value) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(_):
                self.isSignupSucceed.onNext(true)
                
            case .failure(let error):
                self.isSignupSucceed.onError(error)
            }
        }
    }
}
