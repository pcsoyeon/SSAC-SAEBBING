//
//  HTTPRequest.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

protocol RequestProtocol {
    func createRequest(of url: URL, httpMethod: String, with headers: [String : String]?, with body: Data?) -> URLRequest
}
