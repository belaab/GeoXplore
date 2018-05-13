//
//  LoginViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import NVActivityIndicatorView

class LoginViewController: UIViewController, NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let activityIndicatorView =
        NVActivityIndicatorView(frame: UIScreen.main.bounds,
                                type: NVActivityIndicatorType.ballClipRotateMultiple, color: UIColor(red: 113.0/255.0, green: 195.0/255.0, blue: 139.0/255.0, alpha: 1.0))
    
    
    @IBAction func dissmissLoginView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        dismissKeyboard()
        loginButtonPressed()
        showActivityIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        setupActivityIndicator()

    }
    
    private func setupActivityIndicator() {
        activityIndicatorView.backgroundColor = UIColor(red: 33.0/255.0, green: 19.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        view.addSubview(activityIndicatorView)
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
                self.activityIndicatorView.stopAnimating()
            } else {
                self.stopAnimating()
                let alert = UIAlertController(title: "Login failure", message: "Sorry, some error occured. Validate data and try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    private func showActivityIndicator(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading", messageFont: UIFont.systemFont(ofSize: 15, weight: .light), type: activityIndicatorView.type, textColor: UIColor(red: 113.0/255.0, green: 195.0/255.0, blue: 139.0/255.0, alpha: 0.7))
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Almost there...")
        }
    }
    
}









