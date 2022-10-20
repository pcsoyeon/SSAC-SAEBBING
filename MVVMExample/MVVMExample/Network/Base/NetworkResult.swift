//
//  NetworkResult.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
