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
    var friends: Int
    var openedOverallChests: Int
    var title: String
    var achievements: [String]
    
    init(username: String, experience: Int, level: Int, toNextLevel: Double, friends: Int, openedOverallChests: Int,
         title: String, achievements: [String]) {
        self.username = username
        self.experience = experience
        self.level = level
        self.toNextLevel = toNextLevel
        self.friends = friends
        self.openedOverallChests = openedOverallChests
        self.title = title
        self.achievements = achievements
    }
    
    required init?(map: Map) {
        self.username = ""
        self.experience = 0
        self.level = 0
        self.toNextLevel = 0.0
        self.friends = 0
        self.openedOverallChests = 0
        self.title = ""
        self.achievements = [""]
    }
    
    
    func mapping(map: Map) {
        self.username <- map["username"]
        self.experience <- map["experience"]
        self.level <- map["level"]
        self.toNextLevel <- map["toNextLevel"]
        self.friends <- map["friends"]
        self.openedOverallChests <- map["openedOverallChests"]
        self.title <- map["title"]
        self.achievements <- map["achievements"]
    }
}

