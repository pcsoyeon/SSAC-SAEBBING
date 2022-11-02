//
//  SignupView.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SignupViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var userNameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private var signupButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Property
    
    private let viewModel = SignupViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
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
    }
    
    func bind() {
        userNameTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.userName.accept(text)
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.email.accept(text)
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.password.accept(text)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .asDriver(onErrorJustReturn: false)
            .drive(signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map { $0 == true ? UIColor.systemPink : UIColor.systemGray4 }
            .asDriver(onErrorJustReturn: .systemGray4)
            .drive(signupButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestSignin()
            }
            .disposed(by: disposeBag)

        viewModel.isSucceed
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, value in
                
                if value {
                    vc.navigationController?.pushViewController(SigninViewController(), animated: true)
                }
                
            } onError: { error in
                self.presentAlert("로그인 실패", "\(error)")
            } onCompleted: {
                print("======== 완료")
            } onDisposed: {
                print("======== 버려")
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
