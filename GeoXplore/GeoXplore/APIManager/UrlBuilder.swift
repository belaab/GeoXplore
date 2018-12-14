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
    case getTitles
}


extension RequestType: TargetType {

    var url: URL {
        switch self {
        case .login:
            return URL(string: "https://geoxplore-api.herokuapp.com/login")!
        case .register:
            return URL(string: "https://geoxplore-api.herokuapp.com/user-management/user/create")!
        case .postLocation:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/home")!
        case .getBoxes:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/chests")!
        case .getStatistics:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/statistics")!
        case .getRanking:
            return URL(string: "https://geoxplore-api.herokuapp.com/community/ranking")!
        case .postOpenedChest(let id):
            return URL(string: "https://geoxplore-api.herokuapp.com/user/chest/open/" + id)!
        case .getHome:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/get-home")!
        case .editAvatar:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/avatar")!
        case .downloadAvatar:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/avatar")!
        case .getRankingAvatarFor(let username):
            return URL(string: "https://geoxplore-api.herokuapp.com/community/avatar/" + username)!
        case .getFriends:
            return URL(string: "https://geoxplore-api.herokuapp.com/community/friends")!
        case .addFriend(let username):
            return URL(string: "https://geoxplore-api.herokuapp.com/community/friend/add/" + username)!
        case .getTitles:
            return URL(string: "https://geoxplore-api.herokuapp.com/user/titles")!
        }
        
    }
}
