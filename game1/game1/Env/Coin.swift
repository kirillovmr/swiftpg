//
//  Coin.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Coin: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 26, height: 26)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var value = 1

    init() {
        let bronzeTexture = textureAtlas.textureNamed("coin_bronze")
        super.init(texture: bronzeTexture, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.zPosition = 2
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        self.physicsBody?.collisionBitMask = 0 
    }

    // A function to transform this coin into gold!
    func turnToGold() {
        self.texture = textureAtlas.textureNamed("coin_gold")
        self.value = 5
    }
    
    func collect() {
        // Prevent further contact:
        self.physicsBody?.categoryBitMask = 0
        // Fade out, move up, and scale up the coin:
        let collectAnimation = SKAction.group([
            SKAction.fadeAlpha(to: 0, duration: 0.2),
            SKAction.scale(to: 1.5, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0, dy: 25),
               duration: 0.2)
        ])
        // After fading it out, move the coin out of the way
        // and reset it to initial values until the encounter
        // system re-uses it:
        let resetAfterCollected = SKAction.run {
            self.position.y = 5000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
        }
        // Combine the actions into a sequence:
        let collectSequence = SKAction.sequence([
            collectAnimation,
            resetAfterCollected
        ])
        // Run the collect animation:
        self.run(collectSequence)
    }

    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
