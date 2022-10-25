//
//  RxCocoaInitialViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class RxCocoaInitialViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var button = UIButton().then {
        $0.setTitle("Button", for: .normal)
        $0.setTitleColor(.systemPink, for: .normal)
    }
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureButton()
    }
    
    private func setLayout() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    private func configureButton() {
        button.rx.tap
            .subscribe(with: self) { vc, _ in
                vc.present(RxCocoaExampleViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
