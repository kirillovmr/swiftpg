//
//  Ground.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/26/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    var textureAtlas = SKTextureAtlas(named: "Environment")
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat(1)
    
    func createChildren() {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        let texture = textureAtlas.textureNamed("base")
        let tileSize = CGSize(width: texture.size().width, height: texture.size().height)
        
        var tileCount: CGFloat = 0
        while tileCount*tileSize.width < self.size.width {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount*tileSize.width
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            self.addChild(tileNode)
            tileCount += 1
        }
        
        let pointTopLeft = CGPoint(x: 0, y: 0)
        let pointTopRight = CGPoint(x: size.width, y: 0)
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
        
        jumpWidth = tileSize.width * floor(tileCount / 3)
    }
    
    func checkForReposition(playerProgress: CGFloat) {
        let groundJumpPosition = jumpWidth * jumpCount
        if playerProgress > groundJumpPosition {
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }
}
