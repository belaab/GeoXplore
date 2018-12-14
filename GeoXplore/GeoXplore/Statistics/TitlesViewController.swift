//
//  TitlesViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 14/12/2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class TitlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var titles =  [ "Legendarny zbieracz",
    "Stały bywalec",
    "Wytrwały"]
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadTitles()
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.estimatedRowHeight = 260
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }
    
    func downloadTitles() {
        RequestManager.sharedInstance.getTitles { (titlesArray) in
            self.titles = titlesArray
        }
    }

}


extension TitlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        cell.title.text = titles[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

