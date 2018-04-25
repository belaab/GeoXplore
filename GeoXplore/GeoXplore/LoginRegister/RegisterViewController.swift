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
    
    func registerButtonPressed(){
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text
            else { print("invalid data"); return }
    
        RequestManager.sharedInstance.registerUser(username: username, password: password, email: email) { (result) in
            print(result)
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

    }

    
}
