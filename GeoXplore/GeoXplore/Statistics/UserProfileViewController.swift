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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
        self.userPhoto.clipsToBounds = true
        getUserInfo()
    }
    
    func getUserInfo() {
        
        RequestManager.sharedInstance.getUserStatistics { (result, profile, error) in
            switch result {
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








