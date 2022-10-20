//
//  ViewController.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    private lazy var layout = UICollectionViewCompositionalLayout.list(using: configuration)
    
    private lazy var colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        fetchAllPhotos()
    }
    
    // MARK: - UI Method
    
    private func configureHierachy() {
        
    }
    
    private func configureCollectionView() {
        
    }
}

// MARK: - Network

extension ViewController {
    private func fetchAllPhotos() {
        PhotoListAPIManager.shared.requestPhotoList { photo, statusCode, error in
            dump(photo)
        }
    }
}
