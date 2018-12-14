//
//  TitleTableViewCell.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 14/12/2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        contentView.backgroundColor = .clear
    }
    
}
