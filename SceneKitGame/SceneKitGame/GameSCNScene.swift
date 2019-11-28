//
//  GameSCNScene.swift
//  SceneKitGame
//
//  Created by Viktor Kirillov on 11/27/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SceneKit

class GameSCNScene: SCNScene, SCNPhysicsContactDelegate {
    var scnView: SCNView!
    var _size: CGSize!
    
    var hero: Hero!
    
    init(currentview view: SCNView) {
        super.init()
        
        scnView = view
        _size = scnView.bounds.size

        scnView.scene = self
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.yellow
        
//        addGeometryNode()
        addLightSourceNode()
        addCameraNode()
//        addFloorNode()
        
        self.physicsWorld.gravity = SCNVector3Make(0, -500, 0)
        self.physicsWorld.contactDelegate = self
        scnView.debugOptions = SCNDebugOptions.showPhysicsShapes
        
        self.hero = Hero(currentScene: self)
        hero.position = SCNVector3Make(0, 5, 0)
        
        let groundBox = SCNBox(width: 10, height: 2, length: 10, chamferRadius: 0)
        let groundNode = SCNNode(geometry: groundBox)
                
        groundNode.position = SCNVector3Make(0, -1.01, 0)
        groundNode.physicsBody = SCNPhysicsBody.static()
        groundNode.physicsBody?.restitution = 0.0
        groundNode.physicsBody?.friction = 1.0
        groundNode.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
        groundNode.physicsBody?.contactTestBitMask = PhysicsCategory.hero.rawValue

        groundNode.name = "ground"
        self.rootNode.addChildNode(groundNode)
    }
    
    func addGeometryNode() {
        let sphereGeometry = SCNSphere(radius: 1.0)
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.orange

        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = SCNVector3Make(0.0, 0.0, 0.0)
        self.rootNode.addChildNode(sphereNode)
    }
    
    func addLightSourceNode() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 10, y: 10, z: 10)
        self.rootNode.addChildNode(lightNode)
            
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        self.rootNode.addChildNode(ambientLightNode)
    }
    
    func addCameraNode() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: -30, y: 5, z: 12)
        cameraNode.eulerAngles.y -= Float(Double.pi/2)
        self.rootNode.addChildNode(cameraNode)
    }
    
    func addFloorNode() {
         let floorNode = SCNNode()
         floorNode.geometry = SCNFloor()
         floorNode.position.y = -1.0
         self.rootNode.addChildNode(floorNode)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
