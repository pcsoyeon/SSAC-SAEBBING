//
//  SignupViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

final class SignupViewModel {
    
    // MARK: - Relay Property
    
    var userName = PublishRelay<String>()
    var email = PublishRelay<String>()
    var password = PublishRelay<String>()
    
    // MARK: - Request Method
    
    func requestSignin() {
        
    }
}
