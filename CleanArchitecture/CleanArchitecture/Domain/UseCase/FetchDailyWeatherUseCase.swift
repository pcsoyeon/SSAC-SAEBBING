//
//  FetchDailyWeatherUseCase.swift
//  CleanArchitecture
//
//  Created by 소연 on 2023/03/18.
//

import Foundation
import RxSwift

/// UseCase
/// 비즈니스 로직을 처리하는 부분
/// execute : 비즈니스 로직, 별도의 비즈니스 로직이 필요하면 이 곳에 추가
/// Dependency Inversion
///   
protocol FetchDailyWeatherUseCaseInterface {
    func execute() -> PublishSubject<Result<[WeatherEntity], Error>>
}

protocol WeatherRepositoryInterface {
    func fetchDailyWeather() -> PublishSubject<Result<[WeatherEntity], Error>>
}

final class FetchDailyWeatherUseCase: FetchDailyWeatherUseCaseInterface {
    private let repository: WeatherRepositoryInterface
    
    init(repository: WeatherRepositoryInterface) {
        self.repository = repository
    }
    
    func execute() -> PublishSubject<Result<[WeatherEntity], Error>> {
        return repository.fetchDailyWeather()
    }
}
