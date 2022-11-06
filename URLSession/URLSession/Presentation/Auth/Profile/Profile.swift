//
//  Profiel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import Foundation

struct Profile: Codable {
    let user: User
    
    static func parse(data: Data) -> Profile? {
        var result: Profile?
        
        do {
            let decoder = JSONDecoder()
            result = try decoder.decode(Profile.self, from: data)
        } catch {
            print(error)
        }
        
        return result
    }
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}
