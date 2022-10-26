//
//  ListViewModel.swift
//  WhatsNew
//
//  Created by 소연 on 2022/10/23.
//

import Foundation

import RxCocoa
import RxSwift

enum ListError: Error {
    case serverError
}

final class ListViewModel {
    var list: CObservable<[Photo]> = CObservable([])
    var photoList = PublishSubject<[Photo]>()
    
    func requestPhotoList() {
        ListAPIManager.shared.fetchPhotoList { [weak self] photoList, statusCode, error in
            guard let self = self else { return }
            guard let photoList = photoList else { return }
            guard let statusCode = statusCode else { return }
            
            if statusCode == 200 {
                self.list.value = photoList
                
            } else {
                print("🔴", statusCode)
            }
        }
    }
    
    func fetchPhotoList() {
        ListAPIManager.shared.fetchPhotoList { [weak self] photoList, statusCode, error in
            guard let self = self else { return }
            guard let photoList = photoList else { return }
            guard let statusCode = statusCode else { return }
            
            if statusCode != 200 {
                self.photoList.onNext(photoList)
                self.photoList.onCompleted()
                dump(photoList)
            } else {
                self.photoList.onError(ListError.serverError)
            }
        }
    }
}
