//
//  ProfileViewModel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/07.
//

import Foundation

import RxCocoa
import RxSwift

final class ProfileViewModel: BaseViewModelAttribute {
    
    struct Input {
        let logoutTap: ControlEvent<Void>
    }
    
    struct Output {
        let logoutTap: ControlEvent<Void>
    }
    
    func transform(from input: Input) -> Output {
        let logoutTap = input.logoutTap
        
        return Output(logoutTap: logoutTap)
    }
}
