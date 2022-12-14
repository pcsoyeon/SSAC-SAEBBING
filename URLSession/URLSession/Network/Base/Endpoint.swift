//
//  Endpoint.swift
//  URLSession
//
//  Created by 소연 on 2022/11/04.
//

import Foundation

enum Endpoint {
    static let signup = "/signup"
    static let login = "/login"
    static let profile = "/me"
}

extension Endpoint {
    struct TMDB {
        static let movie = "/movie"
        
        static let popular = "/popular"
    }
}
