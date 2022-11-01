//
//  BaseViewModel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
