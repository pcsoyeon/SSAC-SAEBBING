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
    
    private var imageView = UIImageView()
    
    private var nameLabel = UILabel()
    private var emailLabel = UILabel()
    
    private var logoutButton = UIButton()
    
    // MARK: - Property
    
    private let profileService = ProfileService()
    
    private let viewModel = ProfileViewModel()
    
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
        [imageView, nameLabel, emailLabel, logoutButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
        
        logoutButton.setTitle("로그아웃", for: .normal)
        logoutButton.setTitleColor(.lightGray, for: .normal)
        logoutButton.setTitleColor(.darkGray, for: .highlighted)
    }
    
    func bind() {
        let input = ProfileViewModel.Input(logoutTap: logoutButton.rx.tap)
        
        let output = viewModel.transform(from: input)
        
        output.logoutTap
            .withUnretained(self)
            .flatMapLatest { (vc, _) in
                return vc.presentSignup()
            }
            .subscribe(onCompleted: {
                print("회원가입 화면으로 이동")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Transition

extension ProfileViewController {
    private func presentSignup() -> Completable {
        return Completable.create { completable in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: SignupViewController())
            sceneDelegate?.window?.makeKeyAndVisible()
            
            UserDefaults.standard.removeObject(forKey: Constant.UserDefaults.token)
            
            completable(.completed)
            return Disposables.create()
        }
    }
}

// MARK: - Network

extension ProfileViewController {
    private func fetchProfile() throws {
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
