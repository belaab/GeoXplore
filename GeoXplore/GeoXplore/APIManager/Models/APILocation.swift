//
//  APILocation.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class APILocation: Mappable {
    
    var latitude: String
    var longitude: String
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init?(map: Map) {
        self.latitude = "0"
        self.longitude = "0"
    }

    func mapping(map: Map) {
        self.latitude <- map["latitude"]
        self.longitude <- map["longitude"]
    }
}
