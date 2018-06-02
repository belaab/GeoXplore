//
//  LocalizedStrings.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 01.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import Foundation

extension String {
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
