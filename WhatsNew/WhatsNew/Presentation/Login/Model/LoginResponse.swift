//
//  LoginModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/28.
//

import Foundation

struct LoginResponse: Codable {
    let name: String
    
    init(name:String) {
        self.name = name
    }
}
