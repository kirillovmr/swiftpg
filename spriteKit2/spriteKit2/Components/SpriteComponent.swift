//
//  SpriteComponent.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {

    let node: SKSpriteNode

    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
