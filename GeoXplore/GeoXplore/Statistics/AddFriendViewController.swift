//
//  AddFriendViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 09.06.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColor.clear
     navigationController?.navigationBar.backItem?.title = " "
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.backItem?.title = " "
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = " "

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
      
    
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }


}
