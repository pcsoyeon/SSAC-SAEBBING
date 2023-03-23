//
//  WeatherEntity.swift
//  CleanArchitecture
//
//  Created by 소연 on 2023/03/18.
//

import Foundation

/// Entity
/// clean architecture 구조에서 가장 내부에 존재
/// 외부 변화에 변경될 가능성이 없고 비즈니스 로직의 핵심 기능을 담당하는 데이터 구조
/// 상위 계층에 의존성을 갖고 있지 않아 독립적으로 비지니스 기능을 수행할 수 있어야 한다.
struct WeatherEntity: Identifiable {
    let id: String
    let icon: String
    let location: String
    let temperature: Float
    let description: String
    let date: Date
    
    init(id: String, icon: String, location: String, temperature: Float, description: String, date: Date) {
        self.id = id
        self.icon = icon
        self.location = location
        self.temperature = temperature
        self.description = description
        self.date = date
    }
}
