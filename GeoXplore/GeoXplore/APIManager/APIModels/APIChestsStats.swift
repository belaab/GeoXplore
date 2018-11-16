//
//  APIChestsStats.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class ChestStats: Mappable {
    
    var openedOverallCommonChests: Int
    var openedOverallRareChests: Int
    var openedOverallEpicChests: Int
    var openedOverallLegendaryChests: Int
    var openedLastWeekChests: Int
    
    required init?(map: Map) {
        self.openedOverallCommonChests = 0
        self.openedOverallRareChests = 0
        self.openedOverallEpicChests = 0
        self.openedOverallLegendaryChests = 0
        self.openedLastWeekChests = 0
    }
    
    func mapping(map: Map) {
        self.openedOverallCommonChests <- map["openedOverallCommonChests"]
        self.openedOverallRareChests <- map["openedOverallRareChests"]
        self.openedOverallEpicChests <- map["openedOverallEpicChests"]
        self.openedOverallLegendaryChests <- map["openedOverallLegendaryChests"]
        self.openedLastWeekChests <- map["openedLastWeekChests"]
    }
    
    
}
