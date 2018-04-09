//
//  ChooseSignUpInViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 06.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class ChooseSignUpInViewController: UIViewController {
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let loginViewController = StoryboardManager.loginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let registerViewController = StoryboardManager.registerViewController()
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
