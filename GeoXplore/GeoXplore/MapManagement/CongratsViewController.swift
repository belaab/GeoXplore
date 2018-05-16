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

    @IBAction func showARView(_ sender: Any) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.dismiss(animated: true, completion: nil)
//        }
        
        self.removeFromParentViewController()
        self.present(arBoxViewController, animated: true, completion: nil)
        

        
      //  self.dismiss(animated: true, completion: nil)
//        let arBoxViewController = StoryboardManager.arBoxViewController()
//        self.present(arBoxViewController, animated: true, completion: nil)
    }
    
    
    
    
    //@IBOutlet weak var showARView: UIButton!
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
