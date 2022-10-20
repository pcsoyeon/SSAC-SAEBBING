//
//  PhotoListAPIManager.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

import Alamofire

final class PhotoListAPIManager {
    static let shared = PhotoListAPIManager()
    
    private init() { }
    
    func requestPhotoList(completionHandler: @escaping ([Photo]?, Int?, Error?) -> Void) {
        let url = URLConstant.photoListURL
        let headers: HTTPHeaders = ["Authorization" : APIKey.key]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Photo].self) { response in
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
