//
//  ViewController.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

final class MovieViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let searchBar: UISearchBar = {
        let searhBar = UISearchBar()
        searhBar.searchTextField.borderStyle = .none
        return searhBar
    }()
    
    private let tableView = UITableView(frame: .zero)

    // MARK: - Property
    
    private let movieService = MovieService()
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = MovieViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setAttribute()
        bind()
        
        do {
            try fetchMovieList(page: 1)
        } catch {
            print(error)
        }
    }
}

extension MovieViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        
    }
    
    func setAttribute() {
        
    }
    
    func bind() {
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive { movie in
                dump(movie)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Network

extension MovieViewController {
    private func fetchMovieList(page: Int) throws {
        try movieService.requestPopular(page: page)
            .asDriver(onErrorJustReturn: MovieResponse(page: 0, totalResults: 0, totalPages: 0, results: []))
            .drive { [weak self] response in
                guard let self = self else { return }
                self.viewModel.list.accept(response.results)
            }
            .disposed(by: disposeBag)
    }
}

