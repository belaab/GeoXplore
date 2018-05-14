//
//  BoxModel.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

struct Box: Mappable {
    
    var longitude: Double
    var latitude: Double
    var opened: Bool

    init?(map: Map) {
        self.longitude = 0.0
        self.latitude = 0.0
        self.opened = false
    }
    
    mutating func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        opened <- map["opened"]
    }

}
