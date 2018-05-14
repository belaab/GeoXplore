//
//  RegisterViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
//TODO: TODO: error handling, improve user register

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButtnon(_ sender: UIButton) {
        registerButtonPressed()
    }
    
    @IBAction func dismissRegisterView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsSetup()
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
            let repeatedPassword = repeatPasswordTextField.text else { return }
        
        let validationResult: Bool =
            ![username.matchesRegex(regex: Regex.username.rawValue),
              password.matchesRegex(regex: Regex.password.rawValue),
              email.matchesRegex(regex: Regex.email.rawValue),
              password == repeatedPassword].contains(false)
        
        if validationResult {
            registerButton.isEnabled = true
            registerButton.alpha = 1.0
        } else {
            registerButton.isEnabled = false
            registerButton.alpha = 0.5
        }
        
    }
    
    private func registerButtonPressed() {
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
            let repeatedPassword = repeatPasswordTextField.text else { return }
        
        RequestManager.sharedInstance.registerUser(username: username, password: password, email: email) { (result) in
            print(result)
        }
    }
    
    
    private func textFieldsSetup() {
        [self.usernameTextField, self.passwordTextField, self.emailTextField, self.repeatPasswordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        registerButton.isEnabled = false
        registerButton.alpha = 0.5
    }
    
    
}
