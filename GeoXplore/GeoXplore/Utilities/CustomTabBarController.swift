//
//  CustomTabBarController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 22.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: 106/255, green: 34/225, blue: 155/255, alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor(red: 65/255, green: 230/225, blue: 171/255, alpha: 1.0)
    }

}
