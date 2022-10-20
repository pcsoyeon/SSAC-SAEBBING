//
//  PhotoViewModel.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

final class PhotoViewModel {
    
    var photoList: Observable<[Photo]> = Observable([])
    
    func fetchPhotoList() {
        PhotoListAPIManager.shared.requestPhotoList { photo, statusCode, error in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
}
