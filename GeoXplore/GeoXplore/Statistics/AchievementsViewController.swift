//
//  AchievementsViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 14/12/2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var statsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: "StatsTableViewCell")
        tableView.estimatedRowHeight = 260
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }

}

extension AchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as? StatsTableViewCell else { return UITableViewCell() }
        cell.statLabel.text = statsArray[indexPath.row]
        return cell
        
    }

}
