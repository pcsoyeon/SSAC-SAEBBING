//
//  UITableView+.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/08.
//

import UIKit

/// UITableViewCell+
extension UITableViewCell {
    static var id: String {
        return "\(Self.self)"
    }
    
    static func register(_ target: UITableView) {
        target.register(Self.self, forCellReuseIdentifier: Self.id)
    }
}

/// 자주 사용하는 프로퍼티를 묶은 커스텀 테이블 뷰
class UICustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = .clear
        self.separatorStyle = .none
        self.separatorInset = .zero
        self.separatorColor = .clear
        self.sectionHeaderHeight = UITableView.automaticDimension
        self.sectionFooterHeight = UITableView.automaticDimension
        self.rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// UIDynamicTableView
class UIDynamicTableView: UICustomTableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let height = self.contentSize.height + self.contentInset.top + self.contentInset.bottom
        return CGSize(width: self.contentSize.width, height: height)
    }
    
    override func layoutSubviews() {
        self.invalidateIntrinsicContentSize()
        super.layoutSubviews()
    }
    
}
