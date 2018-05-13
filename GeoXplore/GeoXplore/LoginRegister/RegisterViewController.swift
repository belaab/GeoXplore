//
//  RegisterViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    

    private func registerButtonPressed() {
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
            let repeatedPassword = repeatPasswordTextField.text else { return }
        
        if (username.matchesRegex(regex: Regex.username.rawValue)
            && password.matchesRegex(regex: Regex.password.rawValue)
            && email.matchesRegex(regex: Regex.email.rawValue)
            && password.matchesRegex(regex: Regex.password.rawValue)
            /*&& password == repeatedPassword*/ ) {
            registerButton.isEnabled = true
            registerButton.alpha = 1.0
            RequestManager.sharedInstance.registerUser(username: username, password: password, email: email) { (result) in
                print(result)
            }
        }
    }
        
    
    @IBAction func registerButtnon(_ sender: UIButton) {
        registerButtonPressed()
    }

    @IBAction func dismissRegisterView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.isEnabled = false
        registerButton.alpha = 0.5

    }

    
}
