//
//  UserProfileViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 14.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
  
    @IBOutlet weak var userNick: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userExperience: UILabel!
    @IBOutlet weak var userBoxesAmount: UILabel!
    @IBOutlet weak var toNextLevel: UILabel!
    @IBOutlet weak var userLevel: UILabel!
    var chosenPhoto = UIImage()
    var imagePicker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserProfileInfo()
    }
    
    @IBAction func edtitAvatarBtn(_ sender: UIButton) {
        showImagePicker()
    }
    
    private func setupView() {
        userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
        userPhoto.clipsToBounds = true
    }
    
    private func uploadAvatar(image: UIImage) {
        RequestManager.sharedInstance.postAvatarImage(image: image, progressCompletion: { (progress) in
            print(progress)
        }) { (success) in
            switch success{
            case true:
                print("Upload success")
            case false:
                print("Upload error")
            }
        }
    }
    
    private func getUserProfileInfo() {
        
        RequestManager.sharedInstance.downloadAvatarImage { (avatar, result) in
            switch result {
            case true:
                if let userAvatar = avatar {
                    self.userPhoto.image = userAvatar
                } else {
                    print("Eror while applying downloaded image")
                }
            case false:
                print("Downloading image request ended with failure")
            }
        }
        
        RequestManager.sharedInstance.getUserStatistics { (success, profile, error) in
            switch success {
            case true:
                if let userProfileModel = profile {
                    guard let userNick = profile?.username,
                        let userExperience = profile?.experience,
                        let userLevel = profile?.level,
                        let toNextLevel = profile?.toNextLevel,
                        let userOpenedChests = profile?.openedChests else {return}
                    
                        self.userNick.text = userNick
                        self.userBoxesAmount.text = String(describing: userOpenedChests)
                        self.toNextLevel.text = toNextLevel.toPercentages()
                        self.userExperience.text = String(describing: userExperience)
                        self.userLevel.text = String(describing: userLevel)
                }
            case false:
                print("Error while initializing user profile")
            break
            }
        }
    }

 
}

extension UserProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func showImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                self.dismiss(animated: true, completion: { () -> Void in
        
                })
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenPhoto = pickedImage
            userPhoto.image = chosenPhoto
            uploadAvatar(image: chosenPhoto)
        } else {
            print("error while picking image from library")
        }
    }
    
}








