//
//  ListResponse.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

struct Photo: Codable, Hashable {
    let id: String
    let urls: Urls
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls, likes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.likes = try container.decode(Int.self, forKey: .likes)
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
