//
//  SearchPhotoViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchPhotoViewModel {
    
    var list = PublishSubject<[Photo]>()
    
    func requestPhotoList(_ query: String) {
        SearchPhotoAPIManager.shared.fetchPhotoList(query) { [weak self] value, statusCode, error in
            guard let self = self else { return }
            guard let value = value else { return }
            
            self.list.onNext(value.results)
        }
    }
}
