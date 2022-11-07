//
//  MovieViewModel.swift
//  URLSession
//
//  Created by 소연 on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

final class MovieViewModel {
    var list = PublishRelay<[Movie]>()
}

