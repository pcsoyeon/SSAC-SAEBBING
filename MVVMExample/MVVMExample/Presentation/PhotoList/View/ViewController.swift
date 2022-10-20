//
//  ViewController.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    private lazy var layout = UICollectionViewCompositionalLayout.list(using: configuration)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    // MARK: - Property
    
    private var viewModel = PhotoListViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureCollectionView()
        
        viewModel.fetchPhotoList()
        bindData()
    }
    
    // MARK: - UI Method
    
    private func configureHierachy() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Data Bind
    
    private func bindData() {
        viewModel.photoList.bind { photoList in
            var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
            
            snapshot.appendSections([0])
            snapshot.appendItems(photoList)
            
            self.dataSource.apply(snapshot)
        }
    }
}

// MARK: - CollectionView

extension ViewController {
    private func configureCollectionView() {
        // 0. delegate
        collectionView.delegate = self
        
        // 1. layout
        collectionView.collectionViewLayout = createLayout()
        
        // 2. cell register
        let cellRegistration = UICollectionView.CellRegistration<PhotoListCollectionViewCell, Photo>.init { cell, indexPath, itemIdentifier in
            cell.setData(itemIdentifier.id, description: "\(itemIdentifier.likes)")
        }
        
        // 3. data source
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
//        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = createCompositionalLayout()
        layout.configuration = configuration
        return layout
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

// MARK: - CollectionView Protocol

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = PhotoViewController()
        viewController.id = viewModel.photoList.value[indexPath.item].id
        present(viewController, animated: true)
    }
}
