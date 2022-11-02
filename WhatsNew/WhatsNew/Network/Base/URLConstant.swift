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
    
    static let shopURL = "/shop.json"
    static let blogURL = "/blog.json"
}

extension URLConstant {
    static let authBaseURL = "http://api.memolease.com/api/v1"
    
    static let signup = "/signup"
    static let signin = "/login"
    static let profile = "/me"
}
