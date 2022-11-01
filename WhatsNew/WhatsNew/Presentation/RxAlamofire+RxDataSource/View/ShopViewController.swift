//
//  ShopViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import UIKit

import RxCocoa
import RxSwift

final class ShopViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Property
    
    private let viewModel = ShopViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        setAttribute()
        
        bind()
    }
}

extension ShopViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        viewModel.itemRelay
            .asDriver(onErrorJustReturn: [])
            .drive { productList in
                dump(productList)
            } onCompleted: {
                print("완료")
            } onDisposed: {
                print("버려")
            }
            .disposed(by: disposeBag)

    }
}
