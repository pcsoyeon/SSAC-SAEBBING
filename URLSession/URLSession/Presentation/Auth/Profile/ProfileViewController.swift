//
//  ProfileViewController.swift
//  URLSession
//
//  Created by 소연 on 2022/11/05.
//

import UIKit

import RxCocoa
import RxSwift

final class ProfileViewController: UIViewController {

    // MARK: - UI Property
    
    // MARK: - Property
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setAttribute()
        bind()
    }
}

extension ProfileViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        
    }
}
