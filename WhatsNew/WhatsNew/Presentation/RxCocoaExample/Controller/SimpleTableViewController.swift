//
//  SimpleTableViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SimpleTableViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Property
    
    private let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
        bindData()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureTableView()
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Data
    
    private func bindData() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "SimpleCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        
        tableView.rx
            .modelSelected(String.self)
            .withUnretained(self)
            .subscribe(onNext:  { (vc, value) in
                vc.showAlert("", "\(value)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { (vc, indexPath) in
                vc.showAlert("\(indexPath.section)", "Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(_ title: String = "RxExample", _ message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "확인",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
