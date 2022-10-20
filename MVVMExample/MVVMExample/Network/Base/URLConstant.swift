//
//  URLConstant.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

enum URLConstant {
    static let baseURL = "https://api.unsplash.com"
    
    static let searchURL = "https://api.unsplash.com/search/photos?query="
    static let photoListURL = baseURL + "/photos"
    static let photoURL = baseURL + "/photos"
}
