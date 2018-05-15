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
//    var rankingUserAmount = [RankingUser]() {
//        didSet {
//            rankingTableView.reloadData()
//        }
//    }
        override func viewDidLoad() {
            //getRanking()
        super.viewDidLoad()
        self.rankingTableView.register(UINib(nibName: "RankingViewCell", bundle: nil), forCellReuseIdentifier: "RankingViewCell")
        self.rankingTableView.estimatedRowHeight = 260
        self.rankingTableView.rowHeight = UITableViewAutomaticDimension
        getRanking()
        animateTableView()
        self.rankingTableView.delegate = self
        self.rankingTableView.dataSource = self
        rankingTableView.backgroundColor = UIColor.clear
       /// getRanking()
        animateTableView()

       rankingTableView.reloadData()
        animateTableView()
       // rankingTableView.reloadData()
        
    }
    
    
    
    
    func getRanking() {
        RequestManager.sharedInstance.getRankingUsers { (success, rankingUsers, error) in
            if success {
                guard let rankingUserModels = rankingUsers else { return }
                self.rankingUsers = rankingUserModels
                print("Liczba: \(rankingUserModels.count)")
                rankingUsers?.forEach({ (user) in
                    print(user.level)
                    print(user.username)
                    self.rankingTableView.reloadData()
                })
            } else {
                print("Error while initializing ranking cells")
            }
        }
        DispatchQueue.main.async {
            self.rankingTableView.reloadData()
            self.rankingTableView.delegate = self
        }
        self.animateTableView()
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        getRanking()
//    }
    
    
    private func animateTableView() {
        
        let tableHeight: CGFloat = rankingTableView.bounds.size.height
        let tableWidth: CGFloat = rankingTableView.bounds.size.width
        var row = 0
        var index = 0
        let cells = rankingTableView.visibleCells
        let numberOfAwardedPlaces = 3
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            if row < numberOfAwardedPlaces {
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight/2)
            } else {
                cell.transform = CGAffineTransform(translationX: tableWidth, y: 0)
            }
            row += 1
        }
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
    
    
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
      //  let user = rankingUsers[indexPath.row]
//        print(user.username)
//        print(user.level)
     //   rankingUsers.forEach { (user) in
        cell.username.text = rankingUsers[row].username.uppercased()
        cell.level.text = String(describing: rankingUsers[row].level)
        cell.openedChests.text = String(describing: rankingUsers[row].openedChests)
       // }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }

}
