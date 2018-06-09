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
        friendsTableView.register(UINib(nibName: "RankingViewCell", bundle: nil), forCellReuseIdentifier: "RankingViewCell")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backItem?.title = ""
        friendsTableView.estimatedRowHeight = 260
        friendsTableView.rowHeight = UITableViewAutomaticDimension
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.backgroundColor = UIColor.clear
        getUserFriends()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.backItem?.title = " "

    }
    
    
    private func getUserFriends() {
        RequestManager.sharedInstance.getFriends { (success, friends, error) in
            switch success {
            case true:
                guard let userFriends = friends else { return }
                self.friendsArray = userFriends
            case false:
                print("Error while fetching friends")
            }
            self.friendsTableView.reloadData()
        }
    }
    

    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = friendsTableView.dequeueReusableCell(withIdentifier: "RankingViewCell", for: indexPath) as? RankingViewCell else { return UITableViewCell() }
        
        cell.openedChests.textColor = UIColor(red: 132.0/255, green: 230/255, blue: 255.0/255, alpha: 1.0)
        let row = indexPath.row
        cell.username.text = friendsArray[row].username.uppercased()
        cell.level.text = String(describing: friendsArray[row].level)
        cell.openedChests.text = String(describing: friendsArray[row].openedChests)
       
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }


}

