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
    
    var longitude: Double?
    var latitude: Double?
    
    init(longitude: Double?, latitude: Double?) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.longitude <- map["longitude"]
        self.latitude <- map["latitude"]
 
    }
}
