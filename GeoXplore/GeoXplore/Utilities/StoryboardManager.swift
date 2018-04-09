//
//  StoryboardManager.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 08.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

struct StoryboardManager {

    static func viewController<T: UIViewController>(_ type: T.Type, withIdentifier viewControllerIdentifier: String? = nil, fromStoryboard storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let identifier = viewControllerIdentifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        } else {
            return storyboard.instantiateInitialViewController() as! T
        }
    }
    
    struct ViewControllerTypes {
        
    }
    
    enum StoryboardNames: String {
        case y
    }
    
    enum ViewControllerIdentifiers: String {
        case x
    }
    
}

