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
        let register = RegisterViewController.self
        let login = LoginViewController.self
        let setLocation = SetLocationViewController.self
        let boxExplorer = BoxExplorerViewController.self
        let congrats = CongratsViewController.self
    }
    
    enum StoryboardNames: String {
        case Login
        case Register
        case SetLocation
        case BoxExplorer
        case Congrats
    }
    
    enum ViewControllerIdentifiers: String {
        case loginViewController
        case registerViewController
        case setLocationViewController
        case boxExplorerViewController
        case congratsViewController
    }
    
    static func loginViewController() -> LoginViewController {
        let loginVC = self.viewController(ViewControllerTypes().login, withIdentifier: ViewControllerIdentifiers.loginViewController.rawValue, fromStoryboard: StoryboardNames.Login.rawValue)
        return loginVC
    }
    
    static func registerViewController() -> RegisterViewController {
        let registerVC = self.viewController(ViewControllerTypes().register, withIdentifier: ViewControllerIdentifiers.registerViewController.rawValue, fromStoryboard: StoryboardNames.Register.rawValue)
        return registerVC
    }
    
    static func setLocationViewController() -> SetLocationViewController {
        let setLocationVC = self.viewController(ViewControllerTypes().setLocation, withIdentifier: ViewControllerIdentifiers.setLocationViewController.rawValue, fromStoryboard: StoryboardNames.SetLocation.rawValue)
        return setLocationVC
    }
    
    static func boxExplorerViewController() -> BoxExplorerViewController {
        let boxExplorerVC = self.viewController(ViewControllerTypes().boxExplorer, withIdentifier: ViewControllerIdentifiers.boxExplorerViewController.rawValue, fromStoryboard: StoryboardNames.BoxExplorer.rawValue)
        return boxExplorerVC
    }
    
    static func congratsViewController() -> CongratsViewController {
        let congratsVC = self.viewController(ViewControllerTypes().congrats, withIdentifier: ViewControllerIdentifiers.congratsViewController.rawValue, fromStoryboard: StoryboardNames.Congrats.rawValue)
        return congratsVC
    }

}

