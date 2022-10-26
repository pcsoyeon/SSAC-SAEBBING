//
//  RxCocoaExampleViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class RxCocoaExampleViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var button = UIButton().then {
        $0.setTitle("Button", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    // MARK: - Property
    
    private var items = Observable.just(["🫐", "🍋", "🍓"])
    
    private let disposeBag = DisposeBag()
    private var viewModel = ListViewModel()
    
    private var nickname: String = "소깡"
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
//        bindData()
//        setOperator()
        observableAndSubject()
        configureButton()
    }
    
    deinit {
        print("ExampleViewController Deinit")
    }
    
    // MARK: - Data
    
    private func bindData() {
        items
            .subscribe(onNext: { [weak self] itemList in
                guard let self = self else { return }
                self.doSomething(itemList)
            })
            .disposed(by: disposeBag)
        
        items
            .subscribe(with: self, onNext: { vc, itemList in
                vc.doSomething(itemList)
            })
            .disposed(by: disposeBag)
        
        items
            .withUnretained(self)
            .subscribe(onNext: { (vc, itemList) in
                vc.doSomething(itemList)
            })
            .disposed(by: disposeBag)
    }
    
    private func doSomething(_ itemList: [String]){
        print(itemList.joined(separator: "\n"))
    }
    
    private func setOperator() {
        let intervalObservable1 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("interval - \(value)")
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval compledted")
            } onDisposed: {
                print("interval disposed")
            }
        
        intervalObservable1.disposed(by: disposeBag)
    }
    
    private func observableAndSubject() {
        let observableInt = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        observableInt
            .subscribe { value in
                print("observableInt \(value)")
            }
            .disposed(by: disposeBag)
        
        observableInt
            .subscribe { value in
                print("observableInt \(value)")
            }
            .disposed(by: disposeBag)
        
        let subjectInt = BehaviorSubject(value: 0)
        subjectInt.onNext(Int.random(in: 1...100))
        
        subjectInt
            .subscribe { value in
                print("subjectInt \(value)")
            }
            .disposed(by: disposeBag)
        
        subjectInt
            .subscribe { value in
                print("subjectInt \(value)")
            }
            .disposed(by: disposeBag)
    }
    
    private func configureButton() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        button.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.requestPhotoList()
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { vc, value in
                print(value)
                vc.viewModel.fetchPhotoList()
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("완료")
            }, onDisposed: {
                print("끝 버려")
            })
            .disposed(by: disposeBag)
        
        viewModel.photoList
            .withUnretained(self)
            .subscribe(onNext: { vc, value in
                dump(value)
            }, onError: { error in
                print("============ 🔥 에러 🔥 ============")
                print(error)
            }, onCompleted: {
                print("============ 완료 ============")
            }, onDisposed: {
                print("============ 끝 버려 ============")
            })
//            .dispose()
            .disposed(by: disposeBag)
    }
}
