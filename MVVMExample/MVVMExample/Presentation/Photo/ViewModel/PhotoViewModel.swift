//
//  PhotoViewModel.swift
//  MVVMExample
//
//  Created by 소연 on 2022/10/20.
//

import Foundation

final class PhotoViewModel {
    
    private var photo: Observable<Photo> = Observable(Photo(id: "", urls: Urls(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""), likes: 0, description: ""))
    
    func fetchPhoto(_ id: String) {
        PhotoAPIManger.shared.requestPhoto(id) { item, statusCode, error in
            guard let item = item else { return }
            self.photo.value = item
            dump(item)
        }
    }
}
