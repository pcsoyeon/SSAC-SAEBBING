//
//  LoginViewController.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginAPI.shared.requestLogin(email: "12@test.com", password: "09876543")
    }
}
