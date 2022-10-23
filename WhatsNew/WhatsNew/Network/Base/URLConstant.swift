//
//  URLConstant.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

enum URLConstant {
    static let baseURL = "https://api.unsplash.com"
    
    static let searchURL = baseURL + "/search/photos?query="
    static let listURL = baseURL + "/photos"
}
