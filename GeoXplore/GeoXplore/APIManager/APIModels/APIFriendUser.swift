//
//  APIFriendUser.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 08.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class FriendUser: Mappable {
    
    var username: String
    var level: Int
    var openedChests: Int
    
    required init?(map: Map) {
        self.username = ""
        self.level = 0
        self.openedChests = 0
    }
    
    func mapping(map: Map) {
        self.username <- map["username"]
        self.level <- map["level"]
        self.openedChests <- map["openedChests"]
    }
    
}
