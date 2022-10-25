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
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - Propery
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
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
        
        configureDataSource()
        configureSearchBar()
    }
    
    private func setLayout() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, Photo>.init { cell, indexPath, itemIdentifier in
            cell.setData(itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
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
            
            var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
            snapshot.appendSections([0])
            snapshot.appendItems(photoList)
            
            self.dataSource.apply(snapshot)
        }
    }
}

// MARK: - CollectionView

extension SearchPhotoViewController {
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = createCompositionalLayout()
        layout.configuration = configuration
        return layout
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
