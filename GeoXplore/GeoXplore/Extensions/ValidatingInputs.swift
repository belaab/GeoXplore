//
//  ValidatingInputs.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 12.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

extension String {
    
    func matchesRegex(regex: String) -> Bool {
        do {
            let reg = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let match = reg.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
            if match == 1 {
                return true
            }else {
                return false
            }
        } catch {
            print(error)
            return false
        }
    }
    
}

enum Regex: String {
    case username = "^[a-zA-Z0-9]{4,16}$"  //only letters and/or nubers without special characters, min max 16
    case email = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    case password = "^[a-zA-Z0-9]{4,15}$"
}









