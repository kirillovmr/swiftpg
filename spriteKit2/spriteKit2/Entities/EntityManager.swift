//
//  EntityManager.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/4/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    lazy var componentSystems: [GKComponentSystem] = {
      let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
      return [castleSystem]
    }()

    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    let scene: SKScene

    init(scene: SKScene) {
        self.scene = scene
    }

    func add(_ entity: GKEntity) {
        entities.insert(entity)

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }

        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        // 1
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        // 2
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
    func castle(for team: Team) -> GKEntity? {
        for entity in entities {
            if let teamComponent = entity.component(ofType: TeamComponent.self),
                let _ = entity.component(ofType: CastleComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
        }
        return nil
    }
    
    func spawnQuirk(team: Team) {
      // 1
      guard let teamEntity = castle(for: team),
        let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
        let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
          return
      }
        
        let costQuirk = 40

      // 2
      if teamCastleComponent.coins < costQuirk {
        return
      }
      teamCastleComponent.coins -= costQuirk

      // 3
      let monster = Quirk(team: team)
      if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
        spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: scene.size.height * 0.25)
        spriteComponent.node.zPosition = 2
      }
      add(monster)
    }
    
    func entities(for team: Team) -> [GKEntity] {
      return entities.compactMap{ entity in
        if let teamComponent = entity.component(ofType: TeamComponent.self) {
          if teamComponent.team == team {
            return entity
          }
        }
        return nil
      }
    }

    func moveComponents(for team: Team) -> [MoveComponent] {
      let entitiesToMove = entities(for: team)
      var moveComponents = [MoveComponent]()
      for entity in entitiesToMove {
        if let moveComponent = entity.component(ofType: MoveComponent.self) {
          moveComponents.append(moveComponent)
        }
      }
      return moveComponents
    }
}
