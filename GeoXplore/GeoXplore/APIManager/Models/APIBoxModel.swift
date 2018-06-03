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
    
    var id: Int
    var longitude: Double
    var latitude: Double
    var dateCreated: String
    var dateFound: String
    var opened: Bool
    var value: Int

    init?(map: Map) {
        self.id = 0
        self.longitude = 0.0
        self.latitude = 0.0
        self.dateCreated = ""
        self.dateFound = ""
        self.opened = false
        self.value = 0 
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        opened <- map["opened"]
        dateCreated <- map["dateCreated"]
        dateFound <- map["dateFound"]
        value <- map["value"]
    }
}
