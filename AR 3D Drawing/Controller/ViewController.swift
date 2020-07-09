//
//  ViewController.swift
//  AR 3D Drawing
//
//  Created by Carlo Lomello on 05/12/19.
//  Copyright © 2019 Carlo Lomello. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBOutlet weak var BLUE: UIButton!
    @IBOutlet weak var RED: UIButton!
    @IBOutlet weak var YELLOW: UIButton!
    @IBOutlet weak var GREEN: UIButton!
    @IBOutlet weak var WHITE: UIButton!
    @IBOutlet weak var DEL: UIButton!

    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.sceneView.session.run(config)
        self.sceneView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let cameraOrientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let cameraLocation = SCNVector3(transform.m41,transform.m42,transform.m43)
        let cameraCurrentPosition = cameraOrientation + cameraLocation
        


        
        
        DispatchQueue.main.async {
            
            
            if (self.RED.isTouchInside){
                let sphereNode  = SCNNode(geometry: SCNSphere(radius: 0.02))
                    sphereNode.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    print("RED Button is Pressed")
                } else if (self.YELLOW.isTouchInside){
                let sphereNode  = SCNNode(geometry: SCNSphere(radius: 0.02))
                    sphereNode.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
                    print("YELLOW Button is Pressed")
                } else if (self.BLUE.isTouchInside){
                let sphereNode  = SCNNode(geometry: SCNSphere(radius: 0.02))
                    sphereNode.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                    print("BLUE Button is Pressed")
                }else if (self.GREEN.isTouchInside){
                    let sphereNode  = SCNNode(geometry: SCNSphere(radius: 0.02))
                    sphereNode.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                }else if (self.WHITE.isTouchInside){
                    let sphereNode  = SCNNode(geometry: SCNSphere(radius: 0.02))
                    sphereNode.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.addChildNode(sphereNode)
                    sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                }else if (self.DEL.isTouchInside){
                    self.sceneView.scene.rootNode.enumerateChildNodes{
                    (node, stop) in
                    node.removeFromParentNode()
                    }
                }else{
                
                    let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                    pointer.name = "pointer"
                    pointer.position = cameraCurrentPosition
                    self.sceneView.scene.rootNode.enumerateChildNodes({(node,_) in
                        if node.name == "pointer"{
                            node.removeFromParentNode()
                        }
                    })
                     self.sceneView.scene.rootNode.addChildNode(pointer)
                    pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
                }
        }
    }
}

func +(left:SCNVector3,right:SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
