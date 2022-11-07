//
//  Movie.swift
//  URLSession
//
//  Created by 소연 on 2022/11/07.
//

import Foundation


/*
{
    "page": 1,
    "results": [
        {
            "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
            "adult": false,
            "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
            "release_date": "2016-08-03",
            "genre_ids": [
                14,
                28,
                80
            ],
            "id": 297761,
            "original_title": "Suicide Squad",
            "original_language": "en",
            "title": "Suicide Squad",
            "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
            "popularity": 48.261451,
            "vote_count": 1466,
            "video": false,
            "vote_average": 5.91
        }
    ]
    "total_results": 19629,
    "total_pages": 982
}
*/


struct MovieResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    static func parse(data: Data) -> MovieResponse? {
        var result: MovieResponse?
        
        do {
            let decoder = JSONDecoder()
            result = try decoder.decode(MovieResponse.self, from: data)
        } catch {
            print(error)
        }
        
        return result
    }
}

struct Movie: Codable {
    let posterPath: String
    let title: String
    let releaseDate: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case overview
    }
}
