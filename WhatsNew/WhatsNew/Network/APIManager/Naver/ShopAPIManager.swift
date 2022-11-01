//
//  ShopAPIManager.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation

import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa

final class ShopAPIManager {
    private let disposeBag = DisposeBag()
    
    static let shared = ShopAPIManager()
    
    private init() { }
    
    private let url = URLConstant.naverSearchURL + URLConstant.shopURL
    
    private let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.naverClientId,
        "X-Naver-Client-Secret": APIKey.naverClientSecret
    ]
    
    func requestShop(with query: String, completionHandler: @escaping ([Product]) -> Void) {
        let parameters: Parameters = [
            "query": query,
            "display": 10,
            "start": 1,
            "sort": "sim",
        ]
        
        requestJSON(.get, url, parameters: parameters, headers: headers)
            .map { $1 }
            .map { response -> [Product] in
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let productListData = try JSONDecoder().decode(SearchResult.self, from: data)
                return productListData.items
            }
            .bind { value in
                completionHandler(value)
            }
            .disposed(by: disposeBag)
    }
}
