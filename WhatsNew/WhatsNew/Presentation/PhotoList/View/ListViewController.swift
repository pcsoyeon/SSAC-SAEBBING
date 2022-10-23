//
//  ViewController.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/21.
//

import UIKit

import SnapKit
import Then

class ListViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - Property
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureDataSource()
    }
    
    private func configureHierachy () {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
}

extension ListViewController {
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

