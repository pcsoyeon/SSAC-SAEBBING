//
//  Photo.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

// MARK: - Photo

struct Photo: Codable, Hashable {
    let id: String
    let urls: Urls
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls, likes
    }
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

