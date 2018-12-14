//
//  APIRankingUser.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class RankingUser: Mappable {
   
    var username: String
    var level: Int
    var openedChests: Int
    var lastWeekChests: Int
    var title: String
    
    
    required init?(map: Map) {
        self.username = ""
        self.level = 0
        self.openedChests = 0
        self.lastWeekChests = 0
        self.title = ""
    }
    
    func mapping(map: Map) {
        self.username <- map["username"]
        self.level <- map["level"]
        self.openedChests <- map["openedChests"]
        self.lastWeekChests <- map["lastWeekChests"]
        self.title <- map["title"]
    }
    
}

