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
    let secondColor = UIColor (red: 59.0/255.0, green: 37.0/255.0, blue: 70.0/255.0, alpha: 0.0).cgColor
    let firstColor = UIColor (red: 33.0/255.0, green: 19.0/255.0, blue: 40.0/255.0, alpha: 1.0).cgColor
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    func setupGradientView() {
        gradient.frame = self.bounds
        gradient.colors = [firstColor, secondColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y:1) //1 means 100% - to the bottom of the view
        gradient.locations = [0.7, 1.0]
        self.layer.addSublayer(gradient)
    }
}
