//
//  UrlService.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 10.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//wladek user

import Foundation

enum RequestType {
    case login
    case register
    case postLocation
    case getBoxes
    case getStatistics
    case getRanking
    case postOpenedChest(id: String)
    case getHome
    case editAvatar
    case downloadAvatar
    case getRankingAvatarFor(username: String)
    case getFriends
    case addFriend(username: String)
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
        case .getRanking:
            return URL(string: "https://geoxplore-api.herokuapp.com/community/ranking")!
        case .postOpenedChest(let id):
            return URL(string: "https://geoxplore-api.herokuapp.com/user/open-chest/" + id)!
        case .getHome:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/get-home")!
        case .editAvatar:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/avatar")!
        case .downloadAvatar:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/avatar")!
        case .getRankingAvatarFor(let username):
            return URL(string: "https://geoxplore-api.herokuapp.com/community/avatar/" + username)!
        case .getFriends:
            return URL(string: "https://geoxplore-api.herokuapp.com/community/get-friends")!
        case .addFriend(let username):
            return URL(string: "https://geoxplore-api.herokuapp.com/community/add-friend/" + username)!
        }
        
    }
}
