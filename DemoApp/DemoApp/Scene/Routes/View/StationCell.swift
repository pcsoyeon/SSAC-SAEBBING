//
//  PointCell.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/08.
//

import UIKit
import SnapKit

final class StationCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func fetchData(_ data: String) {
        titleLabel.text = data
    }
}

// MARK: - ConfigureUI

extension StationCell {
    
    private func configureUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
    }
    
}
