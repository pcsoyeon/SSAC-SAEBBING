//
//  RxCocoaExampleViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SimplePickerViewExampleViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var pickerView1 = UIPickerView()
    private var pickerView2 = UIPickerView()
    private var pickerView3 = UIPickerView()
    
    // MARK: - Property
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configurePickerView()
    }
    
    private func setLayout() {
        [pickerView1, pickerView2, pickerView3].forEach { pickerView in
            view.addSubview(pickerView)
        }
        
        pickerView1.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(162)
        }
        
        pickerView2.snp.makeConstraints { make in
            make.top.equalTo(pickerView1.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        pickerView3.snp.makeConstraints { make in
            make.top.equalTo(pickerView2.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    // MARK: - RxCocoa Method
    
    private func configurePickerView() {
        // picker view 1
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)
        
        // picker view 2
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                          ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
            })
            .disposed(by: disposeBag)
        
        // picker view 3
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
    }
    
}
