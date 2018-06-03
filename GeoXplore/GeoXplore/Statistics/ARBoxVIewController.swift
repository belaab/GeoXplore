//
//  ARBoxVIewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
// TODO: switch to lazy var boxID

import UIKit
import ARKit

class ARBoxVIewController: UIViewController {

    private let configuration = ARWorldTrackingConfiguration()
    var unblockedBoxID: Int = 0
   
    @IBAction func dismiss(_ sender: UIButton) {
        postOpenedChest(chestID: unblockedBoxID)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    private func postOpenedChest(chestID: Int) {
        let id = String(describing: chestID)
        RequestManager.sharedInstance.postOpenedChest(chestID: id) { (success, experienceGained, statusCode ) in
            if success {
                print("experienceGained: \(experienceGained)")
            } else {
                print("statusCode: \(statusCode)")
            }
        }
    }
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        addARBox()
    }
    
    private func addARBox() {
       
        let spotLight = SCNNode()
        let particleSystem = SCNParticleSystem(named: "Reactor", inDirectory: "art.scnassets")
        let systemNode = SCNNode()
        
        let boxScene = SCNScene(named: "art.scnassets/Chest.scn")
        let boxNode = boxScene?.rootNode.childNode(withName: "Chest", recursively: false)
        
        let systemNodeposition = SCNVector3(0, -1, -3.3)
        let boxNodePosition = SCNVector3(0, -0.2, -3.3)
       
        spotLight.light = SCNLight()
        spotLight.scale = SCNVector3(1,1,1)
        spotLight.light?.intensity = 1000
        spotLight.castsShadow = true
        spotLight.position = SCNVector3Zero
        spotLight.light?.type = SCNLight.LightType.directional
        spotLight.light?.color = UIColor.white
   
        systemNode.position = systemNodeposition
        boxNode?.position = boxNodePosition
        
        guard let scnParticleSystem = particleSystem, let scnBoxNode = boxNode else { return }
        systemNode.addParticleSystem(scnParticleSystem)
        sceneView.scene.rootNode.addChildNode(scnBoxNode)
        sceneView.scene.rootNode.addChildNode(spotLight)
        sceneView.scene.rootNode.addChildNode(systemNode)
    }


}
