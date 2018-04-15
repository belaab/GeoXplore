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
}

extension RequestType: TargetType {
    
    var url: URL {
        switch self {
        case .login:
            return URL(string: "https://geoxplore-api.herokuapp.com/login")!
        case .register:
            return URL(string: "https://geoxplore-api.herokuapp.com/user-management/create-user")!
        }
    }
}
