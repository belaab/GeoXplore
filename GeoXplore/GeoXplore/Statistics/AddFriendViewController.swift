//
//  AddFriendViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    private var keyboardFrame = CGRect()
    private let notificationCenter = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        self.okButton.isEnabled = false
        self.okButton.alpha = 0.75
        
        navigationController?.navigationBar.backItem?.title = " "
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addKeyboardObservers(notificationCenter: notificationCenter)
        usernameTextField.delegate = self
    }
    
    @IBAction func okButtonClicked(_ sender: UIButton) {
        sendAddFriendRequest()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let username = usernameTextField.text else { return }
        let validationResult: Bool = username.matchesRegex(regex: Regex.username.rawValue)
        okButton.isEnabled = validationResult ? true : false
        okButton.alpha = validationResult ? 1.0 : 0.6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = " "

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func sendAddFriendRequest() {
        
        guard let username = usernameTextField.text else { return }
        
        RequestManager.sharedInstance.addFriend(withUsername: username) { (success) in
            self.okButton.isEnabled = false 
            switch (success) {
            case true:
                self.usernameTextField.backgroundColor = Colors.addFriendSuccesGreen
                self.okButton.titleLabel?.text = "Friend added"
            case false:
                self.usernameTextField.backgroundColor = Colors.addFriendFailureRed
                self.okButton.titleLabel?.text = "Invalid username"
            }
            
            UIView.animate(withDuration: 3.0, animations: {
               self.usernameTextField.text = ""
               self.okButton.titleLabel?.text = "OK"
               self.usernameTextField.backgroundColor = Colors.addFriendTextField
            }, completion: nil)
        }
            
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
//                NVActivityIndicatorPresenter.sharedInstance.setMessage("Almost there...")
//            }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    deinit {
        removeKeyboardObservers(notificationCenter: self.notificationCenter)
    }
    


}

//MARK: keyboard handlers

extension AddFriendViewController {
    
   func addKeyboardObservers(notificationCenter: NotificationCenter) {
        self.notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObservers(notificationCenter: NotificationCenter) {
        self.notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        self.notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        self.keyboardFrame = ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)!
        self.view.frame.origin.y =  -self.keyboardFrame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardFrame = ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)!
        self.view.frame.origin.y = 0
        
    }
}
