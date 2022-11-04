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
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

