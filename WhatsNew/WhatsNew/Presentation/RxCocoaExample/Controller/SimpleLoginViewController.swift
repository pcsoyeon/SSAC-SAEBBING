//
//  SimpleLoginViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class SimpleLoginViewController: UIViewController {

    // MARK: - UI Property
    
    private var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private var usernameOutlet = UITextField().then {
        $0.backgroundColor = .systemGray6
    }
    
    private var usernameValidOutlet = UILabel()

    private var passwordOutlet = UITextField().then {
        $0.backgroundColor = .systemGray6
    }
    
    private var passwordValidOutlet = UILabel()

    private var doSomethingOutlet = UIButton().then {
        $0.backgroundColor = . systemPink
    }
    
    // MARK: - Property
    
    private var disposeBag = DisposeBag()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextField()
        bindData()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        view.addSubview(stackView)
        [usernameOutlet, usernameValidOutlet, passwordOutlet, passwordValidOutlet, doSomethingOutlet].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Data
    
    private func configureTextField() {
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
    }
    
    private func bindData() {
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "Rx? 해볼게. 이겨볼게.",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "가보자고.",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

}
