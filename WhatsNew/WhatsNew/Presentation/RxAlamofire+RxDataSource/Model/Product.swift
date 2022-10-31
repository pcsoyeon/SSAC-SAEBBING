//
//  Shop.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation

struct SearchResult: Codable {
    var items: [Product]
}

struct Product: Codable {
    var title: String
    var link: String
    var image: String
    var lprice: String
    var hprice: String
    var mallName: String
    var productId: String
    var productType: String
    var maker: String
    var brand: String
    var category1: String
    var category2: String
    var category3: String
    var category4: String
}

