//
//  Pipe.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/26/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Pipe: SKSpriteNode {
    var textureAtlas = SKTextureAtlas(named: "Environment")
    let distToUpper: CGFloat = 130
    
    func createChildren() {
        let texture = textureAtlas.textureNamed("pipe-green")
        let bottomPipeNode = SKSpriteNode(texture: texture)
        bottomPipeNode.anchorPoint = CGPoint(x: 0, y: 1)
        bottomPipeNode.xScale = 1.3
        bottomPipeNode.yScale = 2
        bottomPipeNode.physicsBody =
            SKPhysicsBody(
                rectangleOf: CGSize(width: bottomPipeNode.size.width, height: bottomPipeNode.size.height),
                center: CGPoint(x: bottomPipeNode.size.width/2, y: -bottomPipeNode.size.height/2)
            )
        bottomPipeNode.physicsBody?.categoryBitMask = PhysicsCategory.pipe.rawValue
        bottomPipeNode.physicsBody?.affectedByGravity = false
        bottomPipeNode.physicsBody?.isDynamic = false
        self.addChild(bottomPipeNode)
        
        // Middle laser
        let laserNode = SKShapeNode(rectOf:
            CGSize(width: bottomPipeNode.size.width / 8, height: bottomPipeNode.size.height / 2))
        laserNode.fillColor = .clear
        laserNode.alpha = 0
        laserNode.position.x += bottomPipeNode.size.width/2
        laserNode.position.y += distToUpper/2
        laserNode.physicsBody = SKPhysicsBody(rectangleOf:
            CGSize(width: bottomPipeNode.size.width / 8, height: bottomPipeNode.size.height / 2))
        laserNode.physicsBody?.categoryBitMask = PhysicsCategory.pipeLaser.rawValue
        laserNode.physicsBody?.affectedByGravity = false
        laserNode.physicsBody?.isDynamic = false
        self.addChild(laserNode)
        
        // Top pipe
        let topPipeNode = SKSpriteNode(texture: texture)
        topPipeNode.anchorPoint = CGPoint(x: 0, y: 0)
        topPipeNode.position.y = bottomPipeNode.position.y + bottomPipeNode.size.height + distToUpper
        topPipeNode.xScale = 1.3
        topPipeNode.yScale = -2
        topPipeNode.physicsBody =
            SKPhysicsBody(
                rectangleOf: CGSize(width: topPipeNode.size.width, height: topPipeNode.size.height),
                center: CGPoint(x: topPipeNode.size.width/2, y: -topPipeNode.size.height/2)
            )
        topPipeNode.physicsBody?.categoryBitMask = PhysicsCategory.pipe.rawValue
        topPipeNode.physicsBody?.affectedByGravity = false
        topPipeNode.physicsBody?.isDynamic = false
        self.addChild(topPipeNode)
    }
    
    func passLaser() {
        
    }
}
