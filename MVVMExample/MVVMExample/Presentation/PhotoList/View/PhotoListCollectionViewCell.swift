//
//  PhotoListCollectionViewCell.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import UIKit

import SnapKit
import Then

class PhotoListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoListCollectionViewCell"
    
    // MARK: - UI Property
    
    private var titleLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    private var descriptionLabel = UILabel().then {
        $0.textColor = .systemPink
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Method
    
    private func configureUI() {
        contentView.backgroundColor = .white
    }
    
    private func setLayout() {
        [titleLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    
    // MARK: - Data
    
    func setData(_ title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
