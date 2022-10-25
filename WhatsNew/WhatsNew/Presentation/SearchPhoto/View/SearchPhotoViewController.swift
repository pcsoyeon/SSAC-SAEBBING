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
        
        viewModel.requestPhotoList("apple")
        viewModel.list.bind { photoList in
            dump(photoList)
        }
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        configureCollectionView()
    }
    
    private func setLayout() {
        
    }
    
    private func configureCollectionView() {
        
    }
}
