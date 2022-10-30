//
//  LoginViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/28.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

protocol BaseViewControllerAttribute {
    func configureHierarchy()
    func setAttribute()
    func bind()
}

final class LoginViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var emailTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    
    private var passwordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    
    private var loginButton = UIButton().then {
        $0.backgroundColor = .systemPink
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
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
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        emailTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        viewModel.emailRelay
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)
        viewModel.passwordRelay
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailRelay)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordRelay)
            .disposed(by: disposeBag)
        
        let isValid = viewModel.isValid
            .share()
        
        isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isValid
            .map { $0 == true ? UIColor.systemPink : UIColor.systemGray4 }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                let request = LoginRequest(email: vc.viewModel.emailRelay.value, password: vc.viewModel.passwordRelay.value)
                vc.viewModel.requestLogin(request)
            }
            .disposed(by: disposeBag)
        
        viewModel.isLoginSucceed
            .withUnretained(self)
            .subscribe { vc, response in
                vc.presentAlert("로그인 성공", "\(response.name)님 환영합니다.")
            } onError: { [weak self] error in
                guard let self = self else { return }
                self.presentAlert("로그인 실패", "\(error)")
            } onCompleted: {
                print("완료")
            } onDisposed: {
                print("버려")
            }
            .disposed(by: disposeBag)
    }
    
    private func presentAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
