//
//  SearchPhoto.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import Foundation

struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
