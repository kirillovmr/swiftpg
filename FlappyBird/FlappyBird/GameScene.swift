//
//  GameScene.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/26/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PhysicsCategory: UInt32 {
    case bird = 1
    case damagedBird = 2
    case ground = 4
    case pipe = 8
    case pipeLaser = 16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var cam = SKCameraNode()
    var hud = HUD()
    
    var ground = Ground()
    var bird = Bird()
    var pipes = [Pipe(), Pipe()]
    
    let birdInitialPosition = CGPoint(x: 150, y: UIScreen.main.bounds.height / 2)
    var birdProgress: CGFloat = 0
    var birdPoints = 0
    
    var pipePosition = CGPoint(x: 200, y: 350)
    var currentPipeIndex = 0
    var nextPipePosition = CGFloat(600)
    
    var gameStarted = false
    var gameEnded = false
    var camShiftCounter: CGFloat = 0
    
    let pointSound = SKAction.playSoundFileNamed("point.wav", waitForCompletion: false)
    let hitSound = SKAction.playSoundFileNamed("hit.wav", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.camera = cam
        cam.position.y = self.size.height / 2
        
        // Position ground
        ground.position = CGPoint(x: -self.size.width * 2, y: 100)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        ground.zPosition = 25
        self.addChild(ground)
        
        // Position bird
        bird.position = birdInitialPosition
        bird.zPosition = 50
        self.addChild(bird)
        
        // Position pipes
        for i in 0..<pipes.count {
            pipes[i].position = CGPoint(x: -2000, y: 350)
            pipes[i].createChildren()
            pipes[i].zPosition = 20
            self.addChild(pipes[i])
        }
        
        // Inform GameScene of contact events
        self.physicsWorld.contactDelegate = self
        
        self.addChild(cam)
        cam.zPosition = 30
        hud.createHudNodes()
        cam.addChild(hud)
        
        
    }
    
    
    override func didSimulatePhysics() {
        if !gameStarted {
            cam.position.x = bird.position.x
        } else {
//MARK:                                                                         Optimize!
            var newCamPosX = bird.position.x + camShiftCounter
            if newCamPosX > bird.position.x + self.size.width/4 {
                newCamPosX = bird.position.x + self.size.width/4
            }
            cam.position.x = newCamPosX
            camShiftCounter += 1
        }
        
        // Keep track of progress
        birdProgress = bird.position.x - birdInitialPosition.x
        
        // Moving Ground
        ground.checkForReposition(playerProgress: birdProgress)
        
        // Return if game not started
        if !gameStarted {
            return
        }
        
        // Moving pipes
        if pipes[currentPipeIndex].position.x + self.size.width/2 < bird.position.x {
            let yShift = CGFloat(arc4random_uniform(4)) * 50 - 100
            pipes[currentPipeIndex].position.x = nextPipePosition
            pipes[currentPipeIndex].position.y += yShift
            
            // Preventing shift out of the screen
            if pipes[currentPipeIndex].position.y >= 650 ||  pipes[currentPipeIndex].position.y <= 100 {
                pipes[currentPipeIndex].position.y -= yShift
            }
            
            print(pipes[currentPipeIndex].position.y)
            nextPipePosition += 300
            currentPipeIndex = (currentPipeIndex + 1) % pipes.count
        }
    }
    
    // When Physics contact occured
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody: SKPhysicsBody
        let playerMask = PhysicsCategory.bird.rawValue | PhysicsCategory.damagedBird.rawValue
        
        otherBody = contact.bodyA.categoryBitMask & playerMask > 0 ? contact.bodyB : contact.bodyA
        
        switch otherBody.categoryBitMask {
        case PhysicsCategory.pipe.rawValue:
            print("Contact pipe")
            endGame()
        case PhysicsCategory.ground.rawValue:
            print("Contact ground")
            endGame()
        case PhysicsCategory.pipeLaser.rawValue:
            addPoint()
        default:
            print("Some contact occured")
        }
    }
    
    func endGame() {
        if !gameEnded {
            bird.die()
            self.run(hitSound)
            hud.showGameOver()
            gameEnded = true
        }
    }
    
    func addPoint() {
        birdPoints += 1
        self.run(pointSound)
        hud.setScoreCount(newScoreCount: birdPoints)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if !gameStarted {
            gameStarted = true
            nextPipePosition += self.bird.position.x
            
            // Notify Bird
            self.bird.removeAction(forKey: "preview")
            
            // Notyfy HUD
            hud.hideGetReadyMessage()
        }
        bird.flap()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            
            // Find the location of the touch:
            let location = t.location(in: self)
            
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            
            // Check for HUD buttons:
            if nodeTouched.name == "play" {
                self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        bird.update()
    }
}
