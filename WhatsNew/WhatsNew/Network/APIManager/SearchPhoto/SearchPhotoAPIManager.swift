//
//  SearchPhotoAPIManager.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import Foundation

import Alamofire

final class SearchPhotoAPIManager {
    static let shared = SearchPhotoAPIManager()
    
    private init() { }
    
    func fetchPhotoList(_ query: String, completionHandler: @escaping(SearchPhoto?, Int?, Error?) -> Void) {
        let url = URLConstant.searchURL
        let headers: HTTPHeaders = [APIKey.authorization : APIKey.key]
        let params: Parameters = [
            "query" : query,
            "page" : 1,
            "per_page" : 10,
            "order_by" : "popular"
        ]
        
        let request = AF.request(url,
                                 method: .get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: headers)
        
        request.responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value):
                completionHandler(value, statusCode, nil)
            case .failure(let error):
                completionHandler(nil, statusCode, error)
            }
        }
    }
}
