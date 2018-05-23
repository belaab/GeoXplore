//
//  DoubleToPercentages.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

extension Double {
    
    func toPercentages() -> String? {
        let minInt = Double(Int.min)
        let maxInt = Double(Int.max)
        
        guard case minInt ... maxInt = self else {
            return nil
        }
        
        let stringWithPercentages = String(describing: Int(self)) + "%"
        return stringWithPercentages
    }
}
