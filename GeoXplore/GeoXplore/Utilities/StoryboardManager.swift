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
        let result = BoxFinderResultViewController.self
        let tabbar = UITabBarController.self
        let ar = ARBoxVIewController.self
        let friends = FriendsViewController.self
        let nav = UINavigationController.self
    }
    
    enum StoryboardNames: String {
        case Login
        case Register
        case SetLocation
        case BoxExplorer
        case Result
        case ARBox
        case Friends
    }
    
    enum ViewControllerIdentifiers: String {
        case loginViewController
        case registerViewController
        case setLocationViewController
        case boxExplorerViewController
        case resultViewController
        case tabbarViewController
        case arBoxViewController
        case friendsViewController
        case navigationController
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
    
    static func boxExplorerViewController() -> UITabBarController {
        let boxExplorerVC = self.viewController(ViewControllerTypes().tabbar, withIdentifier: ViewControllerIdentifiers.tabbarViewController.rawValue, fromStoryboard: StoryboardNames.BoxExplorer.rawValue)
        return boxExplorerVC
    }
    
    static func resultViewController(model: BoxFinderResult) -> BoxFinderResultViewController {
        let resultVC = self.viewController(ViewControllerTypes().result, withIdentifier: ViewControllerIdentifiers.resultViewController.rawValue, fromStoryboard: StoryboardNames.Result.rawValue)
        resultVC.resultModel = model
        return resultVC
    }
    
    static func arBoxViewController(unblockedBoxID: Int, boxValue: Int) -> ARBoxVIewController {
        let arVC = self.viewController(ViewControllerTypes().ar, withIdentifier: ViewControllerIdentifiers.arBoxViewController.rawValue, fromStoryboard: StoryboardNames.ARBox.rawValue)
        arVC.unblockedBoxID = unblockedBoxID
        arVC.boxValue = boxValue
        return arVC
    }
    
//    static func friendsViewController() -> FriendsViewController {
//        let friendsVC = self.viewController(ViewControllerTypes().friends, withIdentifier: ViewControllerIdentifiers.friendsViewController.rawValue, fromStoryboard: StoryboardNames.Friends.rawValue)
//
//            friendsVC.navigationController?.isNavigationBarHidden = false.
//
//        return friendsVC
//    }

    static func friendsViewController() -> UINavigationController {
        let friendsVC = self.viewController(ViewControllerTypes().nav, withIdentifier: ViewControllerIdentifiers.navigationController.rawValue, fromStoryboard: StoryboardNames.Friends.rawValue)
        
        //friendsVC.navigationController?.isNavigationBarHidden = false.
        
        return friendsVC
    }
    
}

