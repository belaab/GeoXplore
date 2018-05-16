//
//  ARBoxVIewController.swift
//  GeoXplore
//
//  Created by Izabela Brzeczek on 15.05.2018.
//  Copyright © 2018 Izabela Brzeczek. All rights reserved.
//

import UIKit
import ARKit

class ARBoxVIewController: UIViewController {
    
    
    

    @IBAction func dismiss(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

      //  self.dismiss(animated: true, completion: nil)
    }

    
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    private func addARBox() {
        let boxScene = SCNScene(named: "art.scnassets/cube.scn")
        let boxNode = boxScene?.rootNode.childNode(withName: "box", recursively: false)
       // else { return }
        boxNode?.position = SCNVector3(0, 0.1, -2)
       // boxNode?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "wood.jpg")
        sceneView.scene.rootNode.addChildNode(boxNode!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin] // helps debug the app by showing if the world origin was properly detected
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        addARBox()
    }


    

}
