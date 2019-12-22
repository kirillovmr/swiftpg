//
//  GameScene.swift
//  spriteKit2
//
//  Created by Viktor Kirillov on 12/2/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

let CollisionCategoryPlayer  : UInt32 = 0x1 << 1
let CollisionCategoryPowerUpOrbs : UInt32 = 0x1 << 2

class GameScene: SKScene {
    
    var entityManager: EntityManager!
    var lastUpdateTimeInterval: TimeInterval = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        entityManager = EntityManager(scene: self)
        let humanCastle = Castle(imageName: "Player", team: .team1)
        humanCastle.component(ofType: SpriteComponent.self)?.node.xScale = 2
        entityManager.add(humanCastle)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        entityManager.update(deltaTime)

        if let human = entityManager.castle(for: .team1),
          let humanCastle = human.component(ofType: CastleComponent.self) {
            print("Coins \(humanCastle.coins)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        entityManager.spawnQuirk(team: .team1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
