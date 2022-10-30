//
//  ReactiveSearchViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation

import RxCocoa
import RxSwift

final class ReactiveSearchViewModel {
    let items = ["iPad", "Mac", "Apple Watch", "MacBook Pro"]
    var filteredItems: BehaviorRelay<[String]> = BehaviorRelay(value: ["iPad", "Mac", "Apple Watch", "MacBook Pro"])
    
    func filterItems(with query: String) {
        let filterd = query != "" ? items.filter { $0.contains(query) } : items
        filteredItems.accept(filterd)
    }
}
