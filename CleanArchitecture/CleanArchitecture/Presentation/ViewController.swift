//
//  ViewController.swift
//  CleanArchitecture
//
//  Created by 소연 on 2023/03/18.
//


import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

/// Main
/// - Main View Controller
final class MainViewController: UIViewController {
    
    // MARK: - Views
    
    // MARK: - Properties
    
    // MARK: - Initialize
    
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
    
    // MARK: - Helpers
    
    private func rxBind() {
        
    }
    
    /// Clear - 보안과 관련된 Properties, Component(TextField, ...)
    private func clearSecureData() {
        
    }
    
    // MARK: - Override
    
    // MARK: - @Objc
    
}

// MARK: - ConfigureUI

extension MainViewController {
    
    private func configureUI() {
        
    }
    
}
