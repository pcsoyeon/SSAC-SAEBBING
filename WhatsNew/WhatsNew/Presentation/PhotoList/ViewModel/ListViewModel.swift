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
    case requestError
    case serverError
}

final class ListViewModel {
    var list: CObservable<[Photo]> = CObservable([])
    var publishSubjectList = PublishSubject<[Photo]>()
    var publishRelay = PublishRelay<[Photo]>()
    
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
    
    func requestPhotoListWithPublishSubject() {
        ListAPIManager.shared.fetchPhotoList { [weak self] photoList, statusCode, error in
            guard let self = self else { return }
            guard let photoList = photoList else { return }
            guard let statusCode = statusCode else { return }
            
            if statusCode == 200 {
                self.publishSubjectList.onNext(photoList)
                self.publishSubjectList.onCompleted()
            } else {
                self.publishSubjectList.onError(ListError.requestError)
            }
        }
    }
    
    func requestPhotoListWithPublishRelay() {
        ListAPIManager.shared.fetchPhotoList { [weak self] photoList, statusCode, error in
            guard let self = self else { return }
            guard let photoList = photoList else { return }
            guard let statusCode = statusCode else { return }
            
            if statusCode == 200 {
                self.publishRelay.accept(photoList)
            } else {
                self.publishSubjectList.onError(ListError.requestError)
            }
        }
    }
}
