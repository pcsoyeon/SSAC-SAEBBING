//
//  ShopViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation

import RxCocoa
import RxSwift

final class ShopViewModel {
    
    var itemRelay = PublishRelay<[Product]>()
    
    func requestSearch(with query: String) {
        ShopAPIManager.shared.requestShop(with: query) { [weak self] productList in
            guard let self = self else { return }
            self.itemRelay.accept(productList)
        }
    }
}
