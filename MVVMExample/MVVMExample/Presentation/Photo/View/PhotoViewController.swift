//
//  PhotoViewController.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

import SnapKit
import Then

class PhotoViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    private lazy var layout = UICollectionViewCompositionalLayout.list(using: configuration)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    // MARK: - Property
    
    var id: String = ""
    private let viewModel = PhotoViewModel()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureCollectionView()
        
        viewModel.fetchPhoto(id)
        bindData()
    }
    
    // MARK: - UI Method
    
    private func configureHierachy() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>.init { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    // MARK: - Data
    
    private func bindData() {
        viewModel.photo.bind { photo in
            var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
            
            let arr = [photo.id, photo.urls.full]
            
            snapshot.appendSections([0])
            snapshot.appendItems(arr)
            
            self.dataSource.apply(snapshot)
        }
    }
}

// MARK: - CollectionView

extension PhotoViewController {
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
