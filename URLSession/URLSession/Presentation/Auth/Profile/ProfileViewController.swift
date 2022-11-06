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
    
    private var nameLabel = UILabel()
    private var emailLabel = UILabel()
    
    // MARK: - Property
    
    private let profileService = ProfileService()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setAttribute()
        bind()
        
        do {
            try fetchProfile()
        } catch {
            print(error)
        }
    }
}

extension ProfileViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        [nameLabel, emailLabel].forEach {
            view.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        
    }
}

extension ProfileViewController {
    func fetchProfile() throws {
        try profileService.requestProfile()
            .asDriver(onErrorJustReturn: Profile(user: User(photo: "", email: "", username: "")))
            .drive { [weak self] profile in
                guard let self = self else { return }
                self.nameLabel.text = profile.user.username
                self.emailLabel.text = profile.user.email
            }
            .disposed(by: disposeBag)
    }
}
