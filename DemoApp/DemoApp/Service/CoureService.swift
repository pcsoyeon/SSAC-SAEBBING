//
//  CoureService.swift
//  DemoApp
//
//  Created by 소연 on 2023/03/23.
//

import RxSwift

final class CourseService: CourseRepository {
    func getCourseListItem(path: CourseItem_API.Path, req: CourseItem_API.Request) -> RxSwift.Observable<CourseItem_API.Response> {
        return Observable.create { observer in
            observer.onNext(CourseItem_API.Response())
            return Disposables.create()
        }
    }
}
