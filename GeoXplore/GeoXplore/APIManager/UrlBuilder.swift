//
//  UrlService.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 10.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

enum RequestType {
    case login
    case register
    case postLocation
    case getBoxes
    case getStatistics
}

extension RequestType: TargetType {
    
    var url: URL {
        switch self {
        case .login:
            return URL(string: "https://geoxplore-api.herokuapp.com/login")!
        case .register:
            return URL(string: "https://geoxplore-api.herokuapp.com/user-management/create-user")!
        case .postLocation:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/set-home")!
        case .getBoxes:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/chests")!
        case .getStatistics:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/my-statistics")!
        }
    }
}
