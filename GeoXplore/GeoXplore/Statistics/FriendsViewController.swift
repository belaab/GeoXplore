//
//  FriendsViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 08.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var friendsArray = [FriendUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
