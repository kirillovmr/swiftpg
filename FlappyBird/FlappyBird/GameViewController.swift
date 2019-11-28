//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Viktor Kirillov on 11/26/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameScene = GameScene()
        let skView = self.view as! SKView
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.showsPhysics = true
        
        gameScene.size = view.bounds.size
        skView.presentScene(gameScene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
