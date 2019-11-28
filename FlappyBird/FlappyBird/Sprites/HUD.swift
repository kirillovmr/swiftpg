//
//  HUD.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/27/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
    var scoreCountText = SKLabelNode(text: "0")
    var scoreCountText2 = SKLabelNode(text: "0")
    
    var gameTitleFront = SKLabelNode(text: "Flappy Bird")
    var gameTitleBack = SKLabelNode(text: "Flappy Bird")
    
    let textAtlas = SKTextureAtlas(named: "Text")
    
    var gameOverSprite = SKSpriteNode()
    var getReadyMessage = SKSpriteNode()
    var playButton = SKSpriteNode()
    
    func createHudNodes() {
        // Score in front
        scoreCountText.fontName = "04b_19"
        scoreCountText.fontColor = .white
        scoreCountText.position.y += UIScreen.main.bounds.height / 2 - 100
        scoreCountText.zPosition = 2
        
        // Score below
        scoreCountText2.fontName = "04b_19"
        scoreCountText2.fontColor = .black
        scoreCountText2.position.y += UIScreen.main.bounds.height / 2 - 103
        scoreCountText2.position.x += 3
        scoreCountText2.zPosition = 1
        
        self.addChild(scoreCountText)
        self.addChild(scoreCountText2)
        
        // Game title
        gameTitleFront.fontName = "04b_19"
        gameTitleFront.fontColor = .white
        gameTitleFront.fontSize = 45
        gameTitleFront.position.y += UIScreen.main.bounds.height / 2 - 200
        gameTitleFront.zPosition = 2
        
        gameTitleBack.fontName = "04b_19"
        gameTitleBack.fontColor = .black
        gameTitleBack.fontSize = 45
        gameTitleBack.position.y += UIScreen.main.bounds.height / 2 - 203
        gameTitleBack.zPosition = 1
        
//        self.addChild(gameTitleFront)
//        self.addChild(gameTitleBack)
        
        // Get ready message
        getReadyMessage = SKSpriteNode(texture: textAtlas.textureNamed("message"))
        getReadyMessage.xScale = 1.5
        getReadyMessage.yScale = 1.5
        self.addChild(getReadyMessage)
        
        // GameOver
        gameOverSprite = SKSpriteNode(texture: textAtlas.textureNamed("gameover"))
        gameOverSprite.xScale = 1.3
        gameOverSprite.yScale = 1.3
        gameOverSprite.position.y += 50
        gameOverSprite.position.y += UIScreen.main.bounds.height
        self.addChild(gameOverSprite)
        
        // Play button
        playButton = SKSpriteNode(texture: textAtlas.textureNamed("playbtn"))
        playButton.size = CGSize(width: 90, height: 60)
        playButton.position.y -= 50
        playButton.position.y += UIScreen.main.bounds.height
        playButton.name = "play"
        self.addChild(playButton)
    }
    
    func setScoreCount(newScoreCount: Int) {
        let number = NSNumber(value: newScoreCount)
        scoreCountText.text = number.stringValue
        scoreCountText2.text = number.stringValue
    }
    
    func hideGetReadyMessage() {
        getReadyMessage.position.y += UIScreen.main.bounds.height
    }
    
    func showGameOver() {
        gameOverSprite.position.y -= UIScreen.main.bounds.height
        playButton.position.y -= UIScreen.main.bounds.height
    }
}
