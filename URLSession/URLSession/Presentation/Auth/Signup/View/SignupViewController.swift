//
//  SignupViewController.swift
//  URLSession
//
//  Created by 소연 on 2022/11/04.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SignupViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var userNameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private var signupButton = UIButton()
    
    // MARK: - Property
    
    private let viewModel = SignupViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setAttribute()
        bind()
    }
}

extension SignupViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        [userNameTextField, emailTextField, passwordTextField, signupButton].forEach {
            view.addSubview($0)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
        
        [userNameTextField, emailTextField, passwordTextField].forEach {
            $0.borderStyle = .roundedRect
        }
        
        userNameTextField.placeholder = "닉네임을 입력해주세요."
        emailTextField.placeholder = "이메일을 입력해주세요."
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        
        signupButton.setTitle("회원가입", for: .normal)
    }
    
    func bind() {
        let input = SignupViewModel.Input(nameText: userNameTextField.rx.text,
                                          emailText: emailTextField.rx.text,
                                          passwordText: passwordTextField.rx.text,
                                          tap: signupButton.rx.tap)
        let output = viewModel.transform(from: input)
        
        output.validation
            .withUnretained(self)
            .bind { (vc, bool) in
                let color: UIColor = bool ? .systemPink : .lightGray
                vc.signupButton.backgroundColor = color
                vc.signupButton.isEnabled = bool
            }
            .disposed(by: disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("화면 전환")
            }
            .disposed(by: disposeBag)
    }
}
