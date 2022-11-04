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
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let nameText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let tap: ControlEvent<Void>
    }
    
    func transform(from input: Input) -> Output {
        Observable.combineLatest(input.nameText.orEmpty, input.emailText.orEmpty, input.passwordText.orEmpty)
            .withUnretained(self)
            .bind { (vc, arg1) in
                let (name, email, password) = arg1
                print(name, email, password)
            }
            .disposed(by: disposeBag)
        
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
        
        return Output(validation: totalValid, tap: input.tap)
    }
}
