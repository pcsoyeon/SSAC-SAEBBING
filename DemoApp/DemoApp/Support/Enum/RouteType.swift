//
//  RouteType.swift
//  DemoApp
//
//  Created by 소연 on 2023/04/08.
//

import UIKit

enum RoutesType {
    case start
    case walking
    case mobilityRental
    case mobilityDriving
    case mobilityReturn
    case busTakingOn
    case busMoving
    case busTakingOff
    case destination
    case none
    
    var color: UIColor {
        switch self {
        case .start:
            return .systemBlue
        case .walking:
            return .lightGray
        case .mobilityRental, .mobilityDriving, .mobilityReturn:
            return .systemGreen
        case .busTakingOn, .busMoving, .busTakingOff:
            return .blue
        case .destination:
            return .black
        case .none:
            return .clear
        }
    }
}
