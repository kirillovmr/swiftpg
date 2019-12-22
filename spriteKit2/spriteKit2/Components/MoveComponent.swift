//
//  MoveComponent.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit

// 1
class MoveComponent: GKAgent2D, GKAgentDelegate {

  // 2
  let entityManager: EntityManager

  // 3
  init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
    delegate = self
    self.maxSpeed = maxSpeed
    self.maxAcceleration = maxAcceleration
    self.radius = radius
    print(self.mass)
    self.mass = 0.01
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // 4
  func agentWillUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }
    
    position = vector2(Float(spriteComponent.node.position.x), Float(spriteComponent.node.position.y))
    
  }

  // 5
  func agentDidUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }

    spriteComponent.node.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
  }
    
//    func closestMoveComponent(for team: Team) -> GKAgent2D? {
//
//      var closestMoveComponent: MoveComponent? = nil
//      var closestDistance = CGFloat(0)
//
//      let enemyMoveComponents = entityManager.moveComponents(for: team)
//      for enemyMoveComponent in enemyMoveComponents {
//        let distance = (CGPoint(enemyMoveComponent.position) - CGPoint(position)).length()
//        if closestMoveComponent == nil || distance < closestDistance {
//          closestMoveComponent = enemyMoveComponent
//          closestDistance = distance
//        }
//      }
//      return closestMoveComponent
//
//    }
}
