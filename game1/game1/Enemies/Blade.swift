//
//  Blade.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Blade: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 63, height: 31)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var spinAnimation = SKAction()

    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        let startTexture = textureAtlas.textureNamed("blade")
        self.physicsBody = SKPhysicsBody(texture: startTexture, size: initialSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        createAnimations()
        self.zPosition = 2
        self.run(spinAnimation)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue
    }

    func createAnimations() {
        let spinFrames: [SKTexture] = [
            textureAtlas.textureNamed("blade"),
            textureAtlas.textureNamed("blade_spin")
        ]
        let spinAction = SKAction.animate(with: spinFrames, timePerFrame: 0.07)
        spinAnimation = SKAction.repeatForever(spinAction)
    }

    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
