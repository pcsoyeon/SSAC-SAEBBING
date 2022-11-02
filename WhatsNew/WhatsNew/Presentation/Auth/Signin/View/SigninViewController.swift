//
//  SigninViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SigninViewController: UIViewController {

    // MARK: - UI Property
    
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private var signinButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Property
    
    private let viewModel = SigninViewModel()
    
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

extension SigninViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        [emailTextField, passwordTextField, signinButton].forEach {
            view.addSubview($0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        signinButton.snp.makeConstraints { make in
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
    }
    
    func bind() {
        let input = SigninViewModel.Input(emailText: emailTextField.rx.text,
                                          passwordText: passwordTextField.rx.text,
                                          signinTap: signinButton.rx.tap)
        let output = viewModel.transform(from: input)
        
        output.emailText
            .asDriver()
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.email.accept(text)
            })
            .disposed(by: disposeBag)
        
        output.passwordText
            .asDriver()
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.viewModel.password.accept(text)
            })
            .disposed(by: disposeBag)

        viewModel.isValid
            .asDriver(onErrorJustReturn: false)
            .drive(signinButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map { $0 == true ? UIColor.systemPink : UIColor.systemGray4 }
            .asDriver(onErrorJustReturn: .systemGray4)
            .drive(signinButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        output.signinTap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestSignin()
            }
            .disposed(by: disposeBag)
        
        output.isSucceed
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { vc, value in
                
                if value {
                    vc.navigationController?.pushViewController(ProfileViewController(), animated: true)
                }
                
            } onError: { error in
                print("======== \(error)")
            } onCompleted: {
                print("======== 완료")
            } onDisposed: {
                print("======== 버려")
            }
            .disposed(by: disposeBag)
    }
}
