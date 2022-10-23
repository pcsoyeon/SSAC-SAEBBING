//
//  ListViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

final class ListViewModel {
    var list: CObservable<[Photo]> = CObservable([])
    
    func requestPhotoList() {
        ListAPIManager.shared.fetchPhotoList { [weak self] photoList, statusCode, error in
            guard let self = self else { return }
            guard let photoList = photoList else { return }
            guard let statusCode = statusCode else { return }
            
            if statusCode == 200 {
                self.list.value = photoList
                dump(photoList)
            } else {
                print("🔴", statusCode)
            }
        }
    }
}
