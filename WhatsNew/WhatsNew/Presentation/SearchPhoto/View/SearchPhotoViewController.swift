//
//  SearchPhotoViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SearchPhotoViewController: UIViewController {
    
    // MARK: - UI Property
    
    private var searchBar = UISearchBar()
    
    // MARK: - Propery
    
    private let viewModel = SearchPhotoViewModel()
    
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
        bindData()
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureCollectionView()
        configureSearchBar()
    }
    
    private func setLayout() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    private func configureCollectionView() {
        
    }
    
    private func configureSearchBar() {
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(with: self) { (vc, value) in
                self.viewModel.requestPhotoList(value)
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Data
    
    private func bindData() {
        viewModel.list.bind { [weak self] photoList in
            guard let self = self else { return }
            dump(photoList)
        }
    }
}
