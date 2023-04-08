//
//  RoutesViewModel.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/08.
//

import RxSwift
import RxCocoa

final class RoutesViewModel {
    
    // MARK: - Essential
    
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var bothways = Bothways()
    private(set) var dependency = Dependency()
    //    private(set) var load: Load // info, load, initialize
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    init() {
        rxBind()
    }
    
    //    init(load: Load) {
    //        self.load = load
    //
    //        rxBind()
    //    }
    
    // MARK: - Helpers
    
    private func rxBind() {
        
    }
    
}

// MARK: - API Request

extension RoutesViewModel {
    
}

// MARK: - ViewModel Structure

extension RoutesViewModel {
    
    enum ErrorResult: Error {
        
    }
    
    struct Input {
        let reqRoutes = PublishRelay<Void>()
    }
    
    struct Output {
//        let routes = PublishRelay<<#Type#>>()
        
//        let error = PublishRelay<ErrorInfo<ErrorResult>>()
    }
    
    /// View <-> ViewModel
    struct Bothways {
        let userInteraction = PublishRelay<Bool>()
        let loading = PublishRelay<Bool>()
    }
    
    /// Service
    struct Dependency {
        
    }
    
    /// Initialze (생성자로 enum 을 필요로 할 경우 해당 enum은 전역으로 선언)
    //    struct Load {
    //
    //    }
    
}
