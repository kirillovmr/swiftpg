//
//  Quirk.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit

class Quirk: GKEntity {

  init(team: Team) {
    super.init()
    let texture = SKTexture(imageNamed: "BlackHole1")
    let spriteComponent = SpriteComponent(texture: texture)
    addComponent(spriteComponent)
    addComponent(TeamComponent(team: team))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
