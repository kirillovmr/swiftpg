//
//  MoveBehaviour.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import GameplayKit
import SpriteKit

// 1
class MoveBehavior: GKBehavior {

  init(targetSpeed: Float, seek: GKAgent, avoid: [GKAgent]) {
    super.init()
    // 2
    if targetSpeed > 0 {
      // 3
      setWeight(0.1, for: GKGoal(toReachTargetSpeed: targetSpeed))
      // 4
      setWeight(0.5, for: GKGoal(toSeekAgent: seek))
      // 5
      setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
    }
  }
}
