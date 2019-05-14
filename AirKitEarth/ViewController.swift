//
//  ViewController.swift
//  AirKitEarth
//
//  Created by André Brilho on 11/05/19.
//  Copyright © 2019 André Brilho. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var globe = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        
        let position = SCNVector3(0, 0, -0.4)
        globe = createAGlobe(atPosition: position)
        scene.rootNode.addChildNode(globe)
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()

        let shapeSpin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 20)
        let repeatSpin = SCNAction.repeatForever(shapeSpin)
        globe.runAction(repeatSpin)
        
        sceneView.session.run(configuration)
    }
    
    func createAGlobe(atPosition: SCNVector3) -> SCNNode {
        
        let sphereGlobe = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/earth.jpeg")
        sphereGlobe.firstMaterial = material
        
        let sphereGlobeNode = SCNNode(geometry: sphereGlobe)
        sphereGlobeNode.position = atPosition

        return sphereGlobeNode
        
    }

}
