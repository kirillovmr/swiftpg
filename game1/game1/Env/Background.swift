//
//  Background.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

// A new class, inheriting from SKSpriteNode and
// adhering to the GameSprite protocol.
class Background: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    var initialSize = CGSize.zero
    
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat(1)

    // This function tiles the ground texture across the width
    // of the Ground node. We will call it from our GameScene.
    func createChildren() {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.zPosition = 0

        // First, load the ground texture from the atlas:
        let texture = textureAtlas.textureNamed("backgroundCastles")

        var tileCount: CGFloat = 0
        let tileSize = CGSize(width: 1024, height: 1024)

        // Build nodes until we cover the entire Ground width
        while tileCount * tileSize.width<self.size.width {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            self.addChild(tileNode)
            tileCount += 1
        }
        
        // Save the width of one-third of the children nodes
        jumpWidth = tileSize.width * floor(tileCount / 3)
    }
    
    func checkForReposition(playerProgress: CGFloat) {
        let jumpPosition = jumpWidth * jumpCount

        if playerProgress >= jumpPosition {
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }

    // Implement onTap to adhere to the protocol:
    func onTap() {}
}

