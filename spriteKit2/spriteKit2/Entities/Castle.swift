//
//  Castle.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Castle: GKEntity {

    init(imageName: String, team: Team) {
        super.init()

        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
        addComponent(CastleComponent())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
