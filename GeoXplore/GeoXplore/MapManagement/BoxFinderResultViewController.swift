//
//  BoxFinderResultViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 18.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
//MARK: temporary placeholder view

class BoxFinderResultViewController: UIViewController {
    
    @IBOutlet weak var ResultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    var resultModel: BoxFinderResult? = nil
    
    let arBoxViewController = StoryboardManager.arBoxViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultTitleLabel.text = resultModel?.resultInfoText
        resultDescriptionLabel.text = resultModel?.resultDescription
        distanceLabel.text = String(describing: resultModel?.distance)
    }
   
    @IBAction func showARView(_ sender: Any) {
        self.removeFromParentViewController()
        self.present(arBoxViewController, animated: true, completion: nil)
    }
    
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
