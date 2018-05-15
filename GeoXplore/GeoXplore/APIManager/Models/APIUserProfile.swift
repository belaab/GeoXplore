//
//  APIUserProfile.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 14.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class UserProfile: Mappable {
    
    var username: String
    var experience: Int
    var level: Int
    var toNextLevel: Double
    var openedChests: Int

    
    init(username: String, experience: Int, level: Int, toNextLevel: Double, openedChests: Int) {
        self.username = username
        self.experience = experience
        self.level = level
        self.toNextLevel = toNextLevel
        self.openedChests = openedChests
    }
    
    required init?(map: Map) {
        self.username = ""
        self.experience = 0
        self.level = 0
        self.toNextLevel = 0.0
        self.openedChests = 0
    }
    
    
    func mapping(map: Map) {
        self.username <- map["username"]
        self.experience <- map["experience"]
        self.level <- map["level"]
        self.toNextLevel <- map["toNextLevel"]
        self.openedChests <- map["openedChests"]
    }
}

