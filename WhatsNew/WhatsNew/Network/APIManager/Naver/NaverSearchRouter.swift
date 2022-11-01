//
//  NaverSearchRouter.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import Foundation
import Alamofire

enum NaverSearchRouter: URLRequestConvertible {
    case blog(query: String)
    case shop(query: String)
}

extension NaverSearchRouter {
    var baseURL: URL {
        return URL(string: URLConstant.naverSearchURL)!
    }
    
    var path: String {
        switch self {
        case .blog:
            return URLConstant.blogURL
        case .shop:
            return URLConstant.shopURL
        }
    }
    
    var headers: [String : String] {
        return ["X-Naver-Client-Id": APIKey.naverClientId,
                "X-Naver-Client-Secret": APIKey.naverClientSecret]
    }
    
    var method: HTTPMethod {
        switch self {
        case .blog, .shop:
            return .get
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .blog(let query), .shop(let query):
            return [
                "query": query,
                "display": "10",
                "start": "1",
                "sort": "sim",
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        switch self {
        case .blog, .shop:
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}
