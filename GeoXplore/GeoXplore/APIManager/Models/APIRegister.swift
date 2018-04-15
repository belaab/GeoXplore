//
//  APIRegister.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation
import ObjectMapper

class APIRegister: Mappable{
    
    var username: String?
    var password: String?
    var email: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
   
    func mapping(map: Map) {
        self.username <- map["username"]
        self.password <- map["password"]
        self.email <- map["email"]
    }
}
