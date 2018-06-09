//
//  BoxFinderResultViewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 18.04.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit


class BoxFinderResultViewController: UIViewController {
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var distanceOval: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceTitleLabel: UILabel!
    var isSuccessVCType: Bool = false
    var resultModel: BoxFinderResult? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVCType()
    }
    
    
    @IBAction func showNextView(_ sender: UIButton) {
        if isSuccessVCType {
            self.removeFromParentViewController()
            let arBoxViewController = StoryboardManager.arBoxViewController(unblockedBoxID: (resultModel?.boxID)!, boxValue: (resultModel?.value)!)
            self.present(arBoxViewController, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func configureVCType() {
        
        guard let resultModelVC = resultModel else { return }
        
        resultTitleLabel.text = resultModelVC.resultInfoText
        resultDescriptionLabel.text = resultModelVC.resultDescription
        distanceLabel.text = resultModelVC.distance.toMeters()
        
        switch(resultModelVC.result) {
        case "failure":
            backgroundImage.image = UIImage(named: "failBackground.png")
            distanceTitleLabel.text = "closest chest distance:"
        case "success":
            isSuccessVCType = true
            backgroundImage.image = UIImage(named: "successBackground.png")
            distanceTitleLabel.text = "found  chest distance:"
        case "allUnblocked":
            backgroundImage.image = UIImage(named: "allCollectedBackground.png")
            distanceOval.alpha = 1.0
            distanceLabel.isHidden = true
            distanceTitleLabel.isHidden = true
        default:
            backgroundImage.image = UIImage(named: "smoothbackground.png")
        }
    }
    
}








