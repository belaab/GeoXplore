//
//  DistanceConverter.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 02.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//
//TODO: TODO: km cases
import Foundation

extension Double {
    
    func toMeters() -> String? {
        
        let minInt = Double(Int.min)
        let maxInt = Double(Int.max)

        guard case minInt ... maxInt = self else {
            return nil
        }
        
        if self == 0 { return "" }
        
        let stringWithPercentages = String(describing: Int(self)) + "m"
        return stringWithPercentages
    }
}
