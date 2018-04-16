//
//  GradientView.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 16.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    func setupGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor] //clear color does not work
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y:1) //1 means 100% - to the bottom of the view
        gradient.locations = [0.7, 1.0]
        self.layer.addSublayer(gradient)
    }
}
