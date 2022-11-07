//
//  MovieService.swift
//  URLSession
//
//  Created by 소연 on 2022/11/07.
//

import Foundation

import RxCocoa
import RxSwift

final class MovieService {
    private let baseURL = URLConstant.tmdbBaseURL
    private var apiKey = APIKey.Key
    
    func requestPopular(page: Int) throws -> Observable<MovieResponse> {
        
        var components = URLComponents(string: baseURL + Endpoint.TMDB.movie + Endpoint.TMDB.popular)
        let key = URLQueryItem(name: "api_key", value: "\(apiKey)")
        let lan = URLQueryItem(name: "language", value: "en-US")
        let page = URLQueryItem(name: "page", value: "\(page)")
        components?.queryItems = [key, lan, page]
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = HTTPMethod.get
        
        return URLSession.shared.rx.response(request: request)
            .map { _, data in
                guard let result = MovieResponse.parse(data: data) else {
                    print("Parsing Error")
                    return MovieResponse(page: 0, totalResults: 0, totalPages: 0, results: [])
                }
                
                return result
            }
    }
}
