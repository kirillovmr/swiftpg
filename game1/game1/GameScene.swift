//
//  GameScene.swift
//  game1
//
//  Created by Viktor Kirillov on 11/22/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

enum PhysicsCategory: UInt32 {
    case player = 1
    case damagedPlayer = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let bg = Background()
    let ground = Ground()
    let player = Player()
    let hud = HUD()
    
    let powerUpStar = Star()
    
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat(150)
    
    var screenCenterY:CGFloat = 0
    
    let initialPlayerPosition = CGPoint(x: 150, y: 250)
    var playerProgress = CGFloat()
    
    var coinsCollected = 0 
    
    // fires every time the game switches to the GameScene
    override func didMove(to view: SKView) {
        self.anchorPoint = .zero
        self.backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        self.camera = cam
    
        // Add ground
        ground.position = CGPoint(x: -self.size.width * 2, y: 70)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
        
        // Add player:
        player.position = initialPlayerPosition
        self.addChild(player)

        // Add background
        bg.position = CGPoint(x: -self.size.width * 2, y: 1024-200)
        bg.size = CGSize(width: self.size.width * 6, height: 0)
        bg.createChildren()
        self.addChild(bg)
        
        encounterManager.addEncountersToScene(gameScene: self)
        
        // Place the star out of the way for now:
        self.addChild(powerUpStar)
        powerUpStar.position = CGPoint(x: -2000, y: -2000)
        
        // Set gravity
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        // Store the vertical center of the screen:
        screenCenterY = self.size.height / 2
        
        // inform GameScene of contact events
        self.physicsWorld.contactDelegate = self
        
        // Add the camera itself to the scene's node tree:
        self.addChild(self.camera!)
        // Position the camera node above the game elements:
        self.camera!.zPosition = 50
        // Create the HUD's child nodes:
        hud.createHudNodes(screenSize: self.size)
        // Add the HUD to the camera's node tree:
        self.camera!.addChild(hud)
        
        // Instantiate a SKEmitterNode with the PierrePath design:
        if let dotEmitter = SKEmitterNode(fileNamed: "PlayerPath") {
            // Position the penguin in front of other game objects:
            player.zPosition = 10
            // Place the particle zPosition behind the penguin:
            dotEmitter.particleZPosition = 8
            // By adding the emitter node to the player, the emitter moves
            // with the penguin and emits new dots wherever the player is
            player.addChild(dotEmitter)
            // However, the particles themselves should target the scene,
            // so they trail behind as the player moves forward.
            dotEmitter.targetNode = self
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody: SKPhysicsBody
        let playerMask = PhysicsCategory.player.rawValue | PhysicsCategory.damagedPlayer.rawValue
        // Use the bitwise AND operator & to find the penguin.
        // This returns a positive number if body A's category
        // is the same as either the penguin or damagedPenguin:
        if (contact.bodyA.categoryBitMask & playerMask) > 0 {
            // bodyA is the penguin, we will test bodyB's type:
            otherBody = contact.bodyB
        }
        else {
            // bodyB is the penguin, we will test bodyA's type:
            otherBody = contact.bodyA
        }
        // Find the type of contact:
        switch otherBody.categoryBitMask {
        case PhysicsCategory.ground.rawValue:
            print("hit the ground")
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        case PhysicsCategory.enemy.rawValue:
            print("take damage")
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        case PhysicsCategory.coin.rawValue:
            print("collect a coin")
            // Try to cast the otherBody's node as a Coin:
            if let coin = otherBody.node as? Coin {
                // Invoke the collect animation:
                coin.collect()
                // Add the value of the coin to our counter:
                self.coinsCollected += coin.value
                hud.setCoinCountDisplay(newCoinCount: self.coinsCollected) 
            }
        case PhysicsCategory.powerup.rawValue:
            print("start the power-up")
            player.starPower()
        default:
            print("contact with no game logic")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            
            // Attempt to downcast the node to the GameSprite protocol
            if let gameSprite = nodeTouched as? GameSprite {
                // If this node adheres to GameSprite, call onTap:
                gameSprite.onTap()
            }
        }
        
        player.startFlapping()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func didSimulatePhysics() {
        // Keep the camera locked at mid screen by default:
        var cameraYPos = screenCenterY
        cam.yScale = 1
        cam.xScale = 1
        
        // Keep track of how far the player has flown
        playerProgress = player.position.x - initialPlayerPosition.x

        // Follow the player up if higher than half the screen:
        if (player.position.y>screenCenterY) {
            cameraYPos = player.position.y
            // Scale out the camera as they go higher:
            let percentOfMaxHeight = (player.position.y - screenCenterY) / (player.maxHeight - screenCenterY)
            let newScale = 1 + percentOfMaxHeight
            cam.yScale = newScale
            cam.xScale = newScale
        }

        // Move the camera for our adjustment:
        self.camera!.position = CGPoint(x: player.position.x, y: cameraYPos)
        
        // Check to see if the ground should jump forward:
        ground.checkForReposition(playerProgress: playerProgress)
        bg.checkForReposition(playerProgress: playerProgress)
        
        // Check to see if we should set a new encounter:
        if player.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 900
            
            // Each encounter has a 10% chance to spawn a star:
            //let starRoll = Int(arc4random_uniform(10))
            let starRoll = 0
            if starRoll == 0 {
                // Only move the star if it is off the screen.
                if abs(player.position.x - powerUpStar.position.x) > 900 {
                    // Y Position 50-450:
                    let randomYPos = 50 + CGFloat(arc4random_uniform(400))
                    powerUpStar.position = CGPoint(x: nextEncounterSpawnPosition, y: randomYPos)
                    // Remove any previous velocity and spin:
                    powerUpStar.physicsBody?.angularVelocity = 0
                    powerUpStar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.update()
    }
} 
