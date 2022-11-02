//
//  NetworkResult.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
