//
//  APIError.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

enum APIError: Int, Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameter = 501
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "알 수 없는 데이터입니다."
        case .noData:
            return "데이터가 없습니다."
        case .failedRequest:
            return "요청에 실패하였습니다."
        case .invalidData:
            return "유효하지 않은 데이터입니다."
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요"
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameter:
            return "입력값을 다시 한번 확인해주세요."
        }
    }
}
