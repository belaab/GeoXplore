//
//  ResultVCTypes.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 02.06.2017.
//  Copyright © 2017 Izabela Brzeczek. All rights reserved.
//

import Foundation

public enum ResultVC: String {
    case success
    case failure
    case allUnblocked
    
    public var type: String {
        switch self {
        case .success:
            return "success"
        case .failure:
            return "failure"
        case .allUnblocked:
            return "allUnblocked"
        }
    }
}


