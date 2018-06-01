//
//  CustomPointAnnotation.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 29.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import Mapbox

class CustomPointAnnotation: MGLPointAnnotation {
    
    var id: Int
    var dateCreated: String
    var dateFound: String
    var opened: Bool
    var value: Int
    
    init(id: Int, dateCreated: String, dateFound: String, opened: Bool, value: Int){
        self.id = id
        self.dateCreated = dateCreated
        self.dateFound = dateFound
        self.opened = opened
        self.value = value
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
