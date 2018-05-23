//
//  CongratsViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 18.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
//MARK: temporary placeholder view

class CongratsViewController: UIViewController {
    
    let arBoxViewController = StoryboardManager.arBoxViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func showARView(_ sender: Any) {
        self.removeFromParentViewController()
        self.present(arBoxViewController, animated: true, completion: nil)
    }
    
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
