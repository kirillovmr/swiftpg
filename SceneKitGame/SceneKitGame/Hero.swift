//
//  Hero.swift
//  SceneKitGame
//
//  Created by Viktor Kirillov on 11/27/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SceneKit

enum PhysicsCategory: Int {
    case hero = 1
    case ground = 2
    case enemy = 4
}

class Hero: SCNNode {
    var isGrounded = false
    
    var monsterNode = SCNNode()
    var jumpPlayer = SCNAnimationPlayer()
    var runPlayer = SCNAnimationPlayer()
    
    init(currentScene: GameSCNScene){
        super.init()
        self.create(currentScene: currentScene)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func create(currentScene: GameSCNScene){
        // Load the monster from the collada scene
        let monsterScene: SCNScene = SCNScene(named: "art.scnassets/theDude.DAE")!
        monsterNode = monsterScene.rootNode.childNode(withName: "CATRigHub001", recursively: false)! //CATRigHub001
        self.addChildNode(monsterNode)
        
        // set the anchor point to the center of the character
        let (minVec, maxVec) = self.boundingBox
        let bound = SCNVector3(x: maxVec.x - minVec.x,
                               y: maxVec.y - minVec.y, z: maxVec.z - minVec.z)
        monsterNode.pivot = SCNMatrix4MakeTranslation(bound.x * 1.1, 0 , 0)
        
        // Set the collision box for the character
        let collisionBox = SCNBox(width: 2, height: 8, length: 2, chamferRadius: 0)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape:SCNPhysicsShape(geometry: collisionBox, options:nil))
        self.physicsBody?.categoryBitMask = PhysicsCategory.hero.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue
        self.physicsBody!.contactTestBitMask = PhysicsCategory.enemy.rawValue
        // set angular velocity factor to 0 so that the character deosnt keel over
        self.physicsBody?.angularVelocityFactor = SCNVector3(0, 0, 0)
        // set the mass so that the character gets affected by gravity
        self.physicsBody?.mass = 20 //4.5
                
        //set the scale and name of the current class
        self.scale = SCNVector3(0.1, 0.1, 0.1)
        
        self.name = "hero"
        // add the current node to the parent scene
        currentScene.rootNode.addChildNode(self)
    }
    
    func jump(){
        
        //print("player jump")
        
        if(isGrounded){
            //print("grounded")
            self.physicsBody?.applyForce(SCNVector3Make(0, 2000, 0), asImpulse: true) //1400
        }
    }

    func update(){

        //print("hero y pos: %f", self.presentation.position.y)
        
        if(self.presentation.position.y < 4.0){
            if(isGrounded == false){
                 isGrounded = true
            }
        } else {
            if(isGrounded == true){
                isGrounded = false
            }
        }
    }
}
