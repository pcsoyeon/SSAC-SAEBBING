//
//  Profile.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}
