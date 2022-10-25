//
//  SearchPhotoViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/25.
//

import Foundation

final class SearchPhotoViewModel {
    
    var list: CObservable<[Photo]> = CObservable([])
    
    func requestPhotoList(_ query: String) {
        SearchPhotoAPIManager.shared.fetchPhotoList(query) { [weak self] value, statusCode, error in
            guard let self = self else { return }
            guard let value = value else { return }
            
            self.list.value = value.results
        }
    }
}
