//
//  Bird.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/26/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

enum BirdColor: String {
    case red = "red"
    case blue = "blue"
    case yellow = "yellow"
}

class Bird: SKSpriteNode {
    var initialSize = CGSize(width: 34, height: 24)
    var textureAtlas = SKTextureAtlas(named: "Bird")
    var birdColor: BirdColor = .red
    
    var flyAnimation = SKAction()
    var dieAnimation = SKAction()
    var previewAnimation = SKAction()
    
    let wingSound = SKAction.playSoundFileNamed("wing.wav", waitForCompletion: false)
    
    var maxFlapForce: CGFloat = 30800
    var rightVelocity: CGFloat = 200
    var flapping = true
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: initialSize.height/2)
        self.physicsBody?.mass = 1
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.friction = 0.4
        self.physicsBody?.linearDamping = 1
        self.physicsBody?.categoryBitMask = PhysicsCategory.bird.rawValue
        self.physicsBody?.contactTestBitMask =
            PhysicsCategory.pipe.rawValue |
            PhysicsCategory.ground.rawValue |
            PhysicsCategory.pipeLaser.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.pipeLaser.rawValue
        
        createAnimation()
        self.run(flyAnimation)
        self.run(previewAnimation, withKey: "preview")
    }
    
    func update() {
        if (flapping) {
            self.physicsBody?.velocity.dx = rightVelocity
        }
    }
    
    func createAnimation() {
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed(birdColor.rawValue + "bird-downflap"),
            textureAtlas.textureNamed(birdColor.rawValue + "bird-midflap"),
            textureAtlas.textureNamed(birdColor.rawValue + "bird-upflap"),
            textureAtlas.textureNamed(birdColor.rawValue + "bird-midflap")
        ]
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.15)
        flyAnimation = SKAction.repeatForever(flyAction)
        
        dieAnimation = SKAction.sequence([
            SKAction.rotate(toAngle: 3, duration: 0.2)
        ])
        
        previewAnimation = SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.flap(bypass: true)
            },
            SKAction.wait(forDuration: 0.622)
        ]))
    }
    
    func die() {
        if (!flapping) { return }
        
        self.removeAllActions()
        self.rightVelocity = 0
        
        self.physicsBody?.applyForce(CGVector(dx: 0, dy: maxFlapForce))
        self.flapping = false
        self.run(self.dieAnimation)
    }
    
    func flap(bypass byp:Bool = false) {
        if !byp {
            if !flapping { return }
        }
        
        self.physicsBody?.velocity.dy = 0
        self.physicsBody?.applyForce(CGVector(dx: 0, dy: maxFlapForce))
        
        if (!byp) {
            self.run(wingSound)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
