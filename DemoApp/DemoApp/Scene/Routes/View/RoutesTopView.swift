//
//  RoutesTopView.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/07.
//

import UIKit
import SnapKit

final class RoutesTopView: UIView {
    
    // MARK: - Views
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func fetchData() {
        
    }
    
}

// MARK: - ConfigureUI

extension RoutesTopView {
    
    private func configureUI() {
        backgroundColor = .yellow
    }
    
}
