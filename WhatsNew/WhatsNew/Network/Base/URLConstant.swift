//
//  URLConstant.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

enum URLConstant {
    static let baseURL = "https://api.unsplash.com"
    
    static let searchURL = baseURL + "/search/photos"
    static let listURL = baseURL + "/photos"
}

extension URLConstant {
    static let naverBaseURL = "https://openapi.naver.com/v1"
    
    static let naverSearchURL = naverBaseURL + "/search"
    
    static let shopURL = naverSearchURL + "/shop.json"
    static let blogURL = naverSearchURL + "/blog.json"
}
