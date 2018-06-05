//
//  ImageWithColor.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 05.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(with color: UIColor) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
