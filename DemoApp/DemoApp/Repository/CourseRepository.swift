//
//  CourseRepository.swift
//  DemoApp
//
//  Created by 소연 on 2023/03/23.
//

import RxSwift

protocol CourseRepository: CourseListRepository { }

protocol CourseListRepository {
    func getCourseListItem(path: CourseItem_API.Path, req: CourseItem_API.Request) -> Observable<CourseItem_API.Response>
}
