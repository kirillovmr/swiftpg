//
//  Bat.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Bat: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 44, height: 24)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var flyAnimation = SKAction()

    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.zPosition = 2
        self.run(flyAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue
    }

    func createAnimations() {
        let flyFrames: [SKTexture] = [
            textureAtlas.textureNamed("bat"),
            textureAtlas.textureNamed("bat_fly")
        ]
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.12)
        flyAnimation = SKAction.repeatForever(flyAction)
    }

    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
