//
//  Bee.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Bee: SKSpriteNode, GameSprite {
    var initialSize: CGSize = CGSize(width: 28, height: 24)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var flyAnimation = SKAction()

    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        createAnimations()
        self.zPosition = 2
        self.run(flyAnimation)
        
        // Attach a physics body, shaped like a circle
        // and sized roughly to our bee.
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue 
    }

    func createAnimations() {
        let flyFrames:[SKTexture] = [textureAtlas.textureNamed("bee"), textureAtlas.textureNamed("bee_fly")]
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
    }

    func onTap() {}

    // Lastly, we are required to add this bit of boilerplate
    // to subclass SKSpriteNode. We will need to do this any
    // time we inherit from SKSpriteNode and use an init function
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
