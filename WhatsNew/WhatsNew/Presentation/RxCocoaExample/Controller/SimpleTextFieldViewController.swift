//
//  SimpleTextFieldViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class SimpleTextFieldViewController: UIViewController {

    // MARK: - UI Property
    
    private var number1 = UITextField()
    private var number2 = UITextField()
    private var number3 = UITextField()
    
    private var result = UILabel()
    
    // MARK: - Property
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureTextField()
    }
    
    // MARK: - UI Method
    
    private func configureHierarchy() {
        [number1, number2, number3].forEach { textField in
            textField.backgroundColor = .systemGray6
            view.addSubview(textField)
        }
        
        number1.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        view.addSubview(result)
        result.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func configureTextField() {
        Observable.combineLatest(number1.rx.text.orEmpty,
                                 number2.rx.text.orEmpty,
                                 number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
}
