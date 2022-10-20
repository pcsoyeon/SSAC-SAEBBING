//
//  PhotoViewModel.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

final class PhotoListViewModel {
    
    var photoList: Observable<[Photo]> = Observable([])
    
    func fetchPhotoList() {
        PhotoListAPIManager.shared.requestPhotoList { list, statusCode, error in
            guard let list = list else { return }
            self.photoList.value = list.sorted(by: { $0.likes > $1.likes })
        }
    }
}
