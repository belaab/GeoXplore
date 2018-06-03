//
//  BoxFinderResult.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 01.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

class BoxFinderResult {
    
    var boxID: Int
    var result: String
    var distance: Double
    var resultInfoText: String
    var resultDescription: String
    
    init(boxID: Int, result: String, distance: Double, resultInfoText: String, resultDescription: String) {
        self.boxID = boxID
        self.distance = distance
        self.result = result
        self.resultInfoText = resultInfoText
        self.resultDescription = resultDescription
    }
}
