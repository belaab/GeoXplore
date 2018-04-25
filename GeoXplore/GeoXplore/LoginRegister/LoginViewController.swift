//
//  LoginViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func dissmissLoginView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func loginButtonPressed() {
        guard let username = loginTextField.text, let password = passwordTextField.text
            else { print("invalid data"); return }
        
        RequestManager.sharedInstance.login(username: username, password: password) { (success, token, error) in
            if success {
                let saveAccessToken: Bool = KeychainWrapper.standard.set(token!, forKey: "accessToken")
                print("Acces token save result: \(saveAccessToken)")
                
                let setLocationViewController = StoryboardManager.setLocationViewController()
                self.present(setLocationViewController, animated: true, completion: nil)
            } else {
                //TODO: TODO
            }
        }
    }
        
    @IBAction func loginButton(_ sender: UIButton) {
        loginButtonPressed()
    }
    
}
