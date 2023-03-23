//
//  SharedContainer.swift
//  DemoApp
//
//  Created by 소연 on 2023/03/23.
//

import Factory

extension Container {
    static let coureRepository = Factory<CourseRepository> { CourseService() }
}
