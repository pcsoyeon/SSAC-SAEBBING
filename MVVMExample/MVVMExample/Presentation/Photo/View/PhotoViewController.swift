//
//  PhotoViewController.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Property
    
    var id: String = ""
    private let viewModel = PhotoViewModel()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhoto(id)
    }
    
}

// MARK: - Network

extension PhotoViewController {
    private func fetchPhoto(_ id: String) {
        viewModel.fetchPhoto(id)
    }
}
