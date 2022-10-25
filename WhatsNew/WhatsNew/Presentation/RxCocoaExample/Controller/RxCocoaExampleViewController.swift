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
    
    // MARK: - Property
    
    private var items = Observable.just(["🫐", "🍋", "🍓"])
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        bindData()
        view.backgroundColor = .systemGray6
        setOperator()
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
}
