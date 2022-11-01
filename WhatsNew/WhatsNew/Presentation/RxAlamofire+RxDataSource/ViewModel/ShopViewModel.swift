//
//  ShopViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation

import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

enum APIError: Error {
    case badUrl
    case invalidResponse
    case failed(Int)
    case invalidData
    case noData
}

final class ShopViewModel {
    
    var itemRelay = PublishRelay<[Product]>()
    private let disposeBag = DisposeBag()
    
    func requestWithURLSession(query: String, display: Int = 10) {
        
    }
    
}
