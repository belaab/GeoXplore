//
//  BoxModel.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 17.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

struct Box {
    var longitude: Double
    var latitude: Double
    var opened: Bool
    
    init(longitude: Double, latitude: Double, opened: Bool) {
        self.longitude = longitude
        self.latitude = latitude
        self.opened = opened
    }
}
