//
//  LoginViewController.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    
    // MARK: - Property
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setAttribute()
        bind()
    }
}

extension LoginViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        [emailTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
        
        [emailTextField, passwordTextField].forEach {
            $0.borderStyle = .roundedRect
        }
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.systemGray6, for: .normal)
    }
    
    func bind() {
        let input = LoginViewModel.Input(emailText: emailTextField.rx.text,
                                         passwordText: passwordTextField.rx.text,
                                         loginTap: loginButton.rx.tap)
        let output = viewModel.transform(from: input)

        output.loginTap
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.requestLogin()

            })
            .disposed(by: disposeBag)
        
        output.isLoginSucceed
            .withUnretained(self)
            .subscribe { vc, value in
                DispatchQueue.main.async {
                    if value {
                        vc.presentProfile()
                    }
                }
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    private func presentProfile() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = ProfileViewController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
