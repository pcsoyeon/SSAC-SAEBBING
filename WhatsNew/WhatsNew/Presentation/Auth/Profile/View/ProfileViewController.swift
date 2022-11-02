//
//  ProfileViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class ProfileViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var userImageView = UIImageView()
    
    private var userNameLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private var userEmailLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - Property
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
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
        [userImageView, userNameLabel, userEmailLabel].forEach {
            view.addSubview($0)
        }
        
        userImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        viewModel.requestProfile()
        
        viewModel.name
            .asDriver()
            .drive(userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.email
            .asDriver()
            .drive(userEmailLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
}
