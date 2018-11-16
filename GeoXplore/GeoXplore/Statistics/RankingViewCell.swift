//
//  RankingViewCell.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class RankingViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var openedChests: UILabel!
    @IBOutlet weak var lastWeekOpened: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true
    }
}
