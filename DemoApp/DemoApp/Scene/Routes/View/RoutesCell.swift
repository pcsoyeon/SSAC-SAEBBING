//
//  RoutesCell.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class RoutesCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var topLineView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "title"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "subtitle"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    private lazy var stationTableView = UIDynamicTableView().then {
        StationCell.register($0)
        $0.isHidden = true
    }
    
    // MARK: - Properties
    
    private var cellType = PublishRelay<RoutesType>()
    private var stationList = PublishRelay<[String]>()
    private var stationCount: Int = 0
    
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        rxBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        cellType.accept(.none)
    }
    
    // MARK: - Helpers
    
    func rxBind() {
        cellType
            .bind(with: self) { owner, type in
                owner.iconImageView.backgroundColor = type.color
                owner.updateUIByRouteType(type: type)
            }
            .disposed(by: disposeBag)
        
        stationList
            .bind(to: stationTableView.rx.items(cellIdentifier: StationCell.id, cellType: StationCell.self)) { index, item, cell in
                cell.fetchData(item)
            }
            .disposed(by: disposeBag)
    }
    
    func fetchData(type: RoutesType, busStations: [String]?) {
        cellType.accept(type)
        
        if let _busStations = busStations {
            stationCount = _busStations.count
            stationList.accept(_busStations)
        }
    }
    
}

// MARK: - ConfigureUI

extension RoutesCell {
    
    private func configureUI() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(topLineView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(stationTableView)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(28)
            make.width.height.equalTo(22)
        }
        topLineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(23)
            make.height.equalTo(1)
            make.right.equalToSuperview().inset(22)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(12)
            make.left.equalTo(iconImageView.snp.right).offset(21)
            make.bottom.equalToSuperview().inset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    private func updateUIByRouteType(type: RoutesType) {
        switch type {
        case .start, .destination, .walking, .busTakingOff, .mobilityRental, .mobilityReturn:
            titleLabel.isHidden = false
            subTitleLabel.isHidden = true
        case .mobilityDriving, .busMoving:
            titleLabel.isHidden = false
            subTitleLabel.isHidden = false
        case .busTakingOn:
            titleLabel.isHidden = false
            subTitleLabel.isHidden = false
        case .none: return
        }
    }
    
    func updateUI(isExpanded: Bool) {
        if isExpanded {
            stationTableView.isHidden = false
        } else {
            stationTableView.isHidden = true
        }
    }
}
