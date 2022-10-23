//
//  ListAPIManager.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

import Alamofire

final class ListAPIManager {
    static let shared = ListAPIManager()
    
    private init() { }
    
    func fetchPhotoList(completionHandler: @escaping ([Photo]?, Int?, Error?) -> Void) {
        let url = URLConstant.listURL
        let headers: HTTPHeaders = [APIKey.authorization : APIKey.key]
        let params = ["page" : 1,
                      "per_page" : 10]
        
        let request = AF.request(url,
                                 method: .get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: headers)
        
        request.responseDecodable(of: [Photo].self) { response in
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
