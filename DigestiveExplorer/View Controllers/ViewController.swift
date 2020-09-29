//
//  ViewController.swift
//  DigestiveExplorer
//
//  Created by Noa on 3/30/18.
//  Copyright © 2018 Noa Souccar. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreMotion
import ModelIO








class ViewController: UIViewController, ARSCNViewDelegate {

  
    @IBOutlet weak var sceneView: ARSCNView!
    
    

    
    private var hud: MBProgressHUD!
    
    
    private var newAngleY: Float = 0.0
    private var currentAngleY: Float = -0.39 
    private var currentAngleX: Float = -1.64
    private var newAngleX: Float = 0.0
    private var localTranslationPosition: CGPoint!

   
    private var counter: Int = 0
    private var upConstraints: [NSLayoutConstraint] = []
  

    


    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       let scene = SCNScene()
       
        sceneView.scene = scene
    sceneView.autoenablesDefaultLighting = true
  self.hud = MBProgressHUD.showAdded(to: self.sceneView, animated: true)
    self.hud.label.text  = "Detecting Plane..."


        
       // Set the view's delegate
        
        
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.showsStatistics = false
        // Create a new scene
       
        // Set the scene to the view
        
 
       let startButton = UIButton(frame: CGRect(x:200 , y: 0, width: 100, height: 50))
       startButton.backgroundColor = .black
        startButton.setTitle("Button", for: .normal)
       startButton.setTitle("Start", for: .normal)
       startButton.titleLabel!.font  = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
        startButton.addTarget(self, action: #selector(start), for: UIControlEvents.touchUpInside)
       self.view.addSubview(startButton)
        
        
        
        
        
        
       
        let hideButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        hideButton.backgroundColor = .black
       
        hideButton.setTitle("Hide Node", for: .normal)
        hideButton.titleLabel!.font  = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
        hideButton.addTarget(self, action: #selector(hideNode), for: UIControlEvents.touchUpInside)
        self.view.addSubview(hideButton)
       

    }
    
    
    internal func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("hello")
        if anchor is ARPlaneAnchor {
            print("Hey")
         
            DispatchQueue.main.async {
                
                self.hud.label.text = "Plane Detected."
               
                self.hud.hide(animated: true, afterDelay: 1.0)
                
                self.hud = MBProgressHUD.showAdded(to: self.sceneView, animated: true)
                self.hud.label.text  = "Tap to Display Node"
                self.hud.hide(animated: true, afterDelay: 1.0)
               
                   self.registerGestureRecognizers()

               
               
            }
        }
    }
    
    
    @objc func start () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            
            let question = CreateQuestions()
            question.moveNode(eular: false, organ: DigestiveSystemParts.mouth, node: bodyNode)
            
            
           
            let button = UIButton(frame: CGRect(x:200 , y: 100, width: 100, height: 50))
            button.backgroundColor = .black
            button.setTitle("Button", for: .normal)
           button.setTitle("Start", for: .normal)
            button.titleLabel!.font  = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
            button.addTarget(self, action: #selector(down), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            
           
        }
        
    }
    
    @objc func down () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            let moveDown = SCNAction.move(by: SCNVector3(0,-0.7,1.7), duration: 2)
            bodyNode.runAction(moveDown)
            
            let button = UIButton(frame: CGRect(x:200 , y: 100, width: 100, height: 50))
            button.backgroundColor = .black
            button.setTitle("Button", for: .normal)
            button.setTitle("Start", for: .normal)
            button.titleLabel!.font  = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
            button.addTarget(self, action: #selector(rotate), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            
        }
        
        
        
    }
    
    @objc func rotate () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            let rotate = SCNAction.move(by: SCNVector3(0,0,1.2), duration: 10)
            bodyNode.runAction(rotate)
            
            let button = UIButton(frame: CGRect(x:200 , y: 100, width: 100, height: 50))
            button.backgroundColor = .black
            button.setTitle("Button", for: .normal)
            button.setTitle("Start", for: .normal)
            button.titleLabel!.font  = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
            button.addTarget(self, action: #selector(slide), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
        }
        
        
        
    }
    
    @objc func slide () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            let rotate = SCNAction.move(by: SCNVector3(0, 3,0), duration: 10)
            bodyNode.runAction(rotate)
            
        }
        
    }
 
    
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        configuration.planeDetection = .horizontal
        
        
        
        
        
        
    }
    @objc func hideNode () {
        sceneView.scene.rootNode.enumerateChildNodes { (bodyNode, stop) in
            bodyNode.removeFromParentNode() }
        counter = 0
    }
    @objc func moveBackward () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            bodyNode.position.z -= 2
             print("z: \(bodyNode.position.z)")
        }
    }
    
    @objc func moveForward () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            bodyNode.position.z += 2
            print("z: \(bodyNode.position.z)")
        }
    }
    @objc func moveRight () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            bodyNode.position.x += 2
                print("x: \(bodyNode.position.x)")
        }
    }
    @objc func moveLeft () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            bodyNode.position.x -= 0.2
                 print("x: \(bodyNode.position.x)")
        }
    }
    
    @objc func moveDown () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
            bodyNode.position.y -= 0.2
        print("y: \(bodyNode.position.y)")
        }
    }
    
    @objc func moveUp () {
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            
                bodyNode.position.y += 0.2
            print("y: \(bodyNode.position.y)")
            }
        }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        configuration.planeDetection = .horizontal
       
    }
 
   
    
 
    private func registerGestureRecognizers() {
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(pinchGesture)
       
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
      
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
       self.sceneView.addGestureRecognizer(panGestureRecognizer)
        
        let longPressedGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
    }
    
    @objc func longPressed (recognizer: UILongPressGestureRecognizer) {
        print("heyno")
        if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
            let mouth = bodyNode.childNode(withName: "Mouth", recursively: true)
            
            
            
            
            
            guard let sceneView = recognizer.view as? ARSCNView else {
                return
            }
            
            
            let touch = recognizer.location(in:sceneView)
            
            let hitTestResults = sceneView.hitTest(touch, options: nil)
            
            
            if hitTestResults.first?.node == mouth
            {
            
                print("hey")
                
                
        }
    
        }
        
    }
   
    
    @objc func panned(recognizer :UIPanGestureRecognizer) {
        
        if recognizer.state == .changed {
            
            guard let sceneView = recognizer.view as? ARSCNView else {
                return
            }
            
            let touch = recognizer.location(in: sceneView)
            let translation = recognizer.translation(in: sceneView)
            
            
            
            
                
            if let bodyNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) {
                
                self.newAngleY = Float(translation.x) * (Float) (Double.pi)/180
                self.newAngleY += self.currentAngleY
                bodyNode.eulerAngles.y = self.newAngleY
                self.newAngleX = Float(translation.y) * (Float) (Double.pi)/180
                self.newAngleX += self.currentAngleX
                bodyNode.eulerAngles.x = self.newAngleX
               
                print("eulx: \(bodyNode.eulerAngles.x)")
                print("euly: \(bodyNode.eulerAngles.y)")
                
            }
            
        }
        else if recognizer.state == .ended {
            self.currentAngleY = self.newAngleY
            self.currentAngleX = self.newAngleX
        }
    }
    
    func presentQuestion () {
    
   
            
    }
    

    
  
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
      
        if self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) != nil {
            
        }
        
       
        var bodyNode: SCNNode!
        let bodyScene = SCNScene(named:"art.scnassets/Man.scn")!
        bodyNode = bodyScene.rootNode.childNode(withName: "Man", recursively: true)
        
    
      

        guard let sceneView = recognizer.view as? ARSCNView else{
            return
        }
        
      
        let touch = recognizer.location(in:sceneView)
        
        let hitTestResults = sceneView.hitTest(touch, types: .estimatedHorizontalPlane)
        
        
        if (hitTestResults.first != nil) &&  self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true) == nil
        {
            
            
            self.sceneView.scene.rootNode.addChildNode(bodyNode!)
            let alert = UIAlertController(title: "Start Game", message: "Center Body In Front of the Screen and Press 'Start'", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Start", style: UIAlertActionStyle.default, handler:    { (alert: UIAlertAction!) in
                let moveToMouth = SCNAction.move(by: SCNVector3(0,0,8), duration: 8)
                bodyNode.runAction(moveToMouth)
            }))
            self.present(alert, animated: true, completion: nil)
                
        }
            

            
           
       
            
        
        


}
        
        
    
    
   
    @objc func pinched(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state   == .changed {
           
           guard let sceneView = recognizer.view as? ARSCNView else{
            return
                
            }
            let touch = recognizer.location(in:sceneView)
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                let DSNode = self.sceneView.scene.rootNode.childNode(withName: "Man", recursively: true)!
              
                let pinchScaleX = Float(recognizer.scale) * DSNode.scale.x
                let pinchScaleY = Float(recognizer.scale) * DSNode.scale.y
                let pinchScaleZ = Float(recognizer.scale) * DSNode.scale.z
                
                DSNode.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
                
                }
          
            
            }
            
        }
 
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: CustomAlertViewDelegate {

func wrongTapped() {
    print("hey")
}

func rightTapped() {
    print("no")
}



}
