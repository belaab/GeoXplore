//
//  RankingViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankingTableView: UITableView!
    var rankingUsers = [RankingUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getRanking()
    }
    
    private func setupView() {
        rankingTableView.register(UINib(nibName: "RankingViewCell", bundle: nil), forCellReuseIdentifier: "RankingViewCell")
        rankingTableView.estimatedRowHeight = 260
        rankingTableView.rowHeight = UITableViewAutomaticDimension
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.backgroundColor = UIColor.clear
    }
    
    private func getRanking() {
        RequestManager.sharedInstance.getRankingUsers { (success, rankingUsers, error) in
            if success {
                guard let rankingUserModels = rankingUsers else { return }
                self.rankingUsers = rankingUserModels.sorted { $0.openedChests  >  $1.openedChests }
                print("Liczba: \(rankingUserModels.count)")
            } else {
                print("Error while initializing ranking cells")
                //TODO: TODO
            }
            self.rankingTableView.reloadData()
        }

    }
    

//    private func getAvatarFor(username: String) -> UIImage {
//        var rankingImage = UIImage(named: "doge")
//
//        RequestManager.sharedInstance.downloadAvatarImage(name: username) { (image, success) in
//            switch success {
//            case true:
//                guard let img = image else { return }
//                rankingImage = img
//            case false:
//                print("Could not dowload image")
//               // rankingImage = UIImage(named: "doge")!
//            }
//        }
//
//        return rankingImage!
//    }

    
}


extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = rankingTableView.dequeueReusableCell(withIdentifier: "RankingViewCell", for: indexPath) as? RankingViewCell
            else { return UITableViewCell() }
        
        cell.backgroundColor = UIColor.clear
        let row = indexPath.row
        cell.username.text = rankingUsers[row].username.uppercased()
        cell.level.text = String(describing: rankingUsers[row].level)
        cell.openedChests.text = String(describing: rankingUsers[row].openedChests)
        print(rankingUsers[row].username)
        RequestManager.sharedInstance.downloadAvatarImage(name: rankingUsers[row].username) { (image, result) in
            switch result {
            case true:
                cell.profileImage.image = image
            case false:
                cell.profileImage.image = UIImage(named: "doge")
            }
        }
        //cell.profileImage.image = getAvatarFor(username: rankingUsers[row].username)
       
        return cell
    }


    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }

}
