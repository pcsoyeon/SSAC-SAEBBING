//
//  ReactiveSearchViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/31.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class ReactiveSearchViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var searchBar = UISearchBar()
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Property
    
    private var viewModel = ReactiveSearchViewModel()
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        setAttribute()
        bind()
        
        configureTableView()
    }
}

extension ReactiveSearchViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        
        tableView.rowHeight = 40
    }
    
    func bind() {
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { vc, value in
                vc.viewModel.filterItems(with: value)
            }
            .disposed(by: disposeBag)
        
        viewModel.filteredItems
            .bind(to: tableView.rx.items(cellIdentifier: "SearchCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(row)번 - \(element)"
            }
            .disposed(by: disposeBag)
    }
}
