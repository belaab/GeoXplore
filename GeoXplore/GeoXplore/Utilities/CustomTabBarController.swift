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
        UITabBar.appearance().tintColor = Colors.loaderBackgroungPurple
        UITabBar.appearance().barTintColor = Colors.tabBarSelectedItemColor
    }
}
