//
//  RoutesVC.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

extension RoutesType {
    static let mock: [RoutesType] = [.start, .walking, .busTakingOn, .busMoving, .busTakingOff, .walking, .destination]
}

/// 경로 상세 화면
/// - RoutesVC
final class RoutesVC: UIViewController {
    
    // MARK: - Views
    
    private lazy var topView = RoutesTopView()
    
    private lazy var routesTableView = UIDynamicTableView().then {
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        RoutesCell.register($0)
    }
    
    // MARK: - Properties
    
    private var viewModel: RoutesViewModel
    private let disposeBag = DisposeBag()
    
    private var expandedIndexSet : IndexSet = []
    
    // MARK: - Initialize
    
    init(viewModel: RoutesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        clearSecureData()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        rxBind()
    }
    
    // MARK: - Navigation
    
    // MARK: - RxBind
    
    private func rxBind() {
        rxBindOutput()
        rxBindViews()
        rxBindInput()
    }
    
    /// Output - Binding (ViewModel -> VC)
    private func rxBindOutput() {
        
    }
    
    /// View - UI Component Handling
    private func rxBindViews() {
        
    }
    
    /// Input - Request (VC -> ViewModel)
    private func rxBindInput() {
        
    }
    
    // MARK: - API Helpers
    
    // MARK: - Helpers
    
    /// Clear - 보안과 관련된 Properties, Component(TextField, ...)
    private func clearSecureData() {
        
    }
    
    // MARK: - @Objc
    
}

// MARK: - UITableView DataSource

extension RoutesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 이미 셀이 펼쳐져 있다면 expandedIndexSet에서 해당 셀을 삭제
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            // 셀이 펼쳐져 있지 않다면 expandedIndexSet에 삽입
            expandedIndexSet.insert(indexPath.row)
        }
        
        // 접혔다가 펼쳐지는 애니메이션 실행
        // reloadRows를 통해서 해당 셀에서만 tableView 갱신 (펼쳐지거나 접히는 효과)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoutesType.mock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoutesCell.id, for: indexPath) as? RoutesCell else { return UITableViewCell() }
        cell.fetchData(type: RoutesType.mock[indexPath.row], busStations: ["경유지1", "경유지2", "경유지3", "경유지4"])
        
        // 셀이 펼쳐져 있다면
        if expandedIndexSet.contains(indexPath.row) {
            // 경유지 테이블 뷰 표시 O
            cell.updateUI(isExpanded: true)
        } else {
            // 셀이 열려있지 않다면
            // 경유지 테이블 뷰 표시 X
            cell.updateUI(isExpanded: false)
        }
        
        return cell
    }
}

// MARK: - ConfigureUI

extension RoutesVC {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        view.addSubview(routesTableView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(110)
        }
        routesTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
