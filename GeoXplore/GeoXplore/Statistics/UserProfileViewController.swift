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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width / 2;
        self.userPhoto.clipsToBounds = true
    }

 
}
