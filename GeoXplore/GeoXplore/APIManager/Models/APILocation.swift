//
//  APILocation.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

struct APILocation: Mappable {
    
    var latitude: String
    var longitude: String
    
    init(longitude: String, latitude: String) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
     init?(map: Map) {
        self.longitude = "0"
        self.latitude = "0"
    }


    mutating func mapping(map: Map) {
        self.longitude <- map["longitude"]
        self.latitude <- map["latitude"]
    }
}
