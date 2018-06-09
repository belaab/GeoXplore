//
//  FriendsViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 08.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var friendsTableView: UITableView!
    var friendsArray = [FriendUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
        friendsTableView.estimatedRowHeight = 260
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.backgroundColor = UIColor.clear
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.backItem?.title = " "
//
//    }
    
    
    

    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = friendsTableView.dequeueReusableCell(withIdentifier: "RankingViewCell", for: indexPath) as? RankingViewCell else { return UITableViewCell() }
        
        let row = indexPath.row
        cell.username.text = friendsArray[row].username.uppercased()
        cell.level.text = String(describing: friendsArray[row].level)
        cell.openedChests.text = String(describing: friendsArray[row].openedChests)
        print(friendsArray[row].username)
       
        RequestManager.sharedInstance.downloadAvatarImage(name: friendsArray[row].username) { (image, result) in
            switch result {
            case true:
                cell.profileImage.image = image
            case false:
                cell.profileImage.image = UIImage(named: "doge")
            }
        }
        
        return cell
    }


}

