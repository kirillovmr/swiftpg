//
//  GameViewController.swift
//  game1
//
//  Created by Viktor Kirillov on 11/22/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()
        
       // Build the menu scene:
       let menuScene = MenuScene()
       let skView = self.view as! SKView
       // Ignore drawing order of child nodes
       // (This increases performance)
       skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        // Set the scale mode fit the window:
//       skView.scaleMode = .aspectFill
       // Size our scene to fit the view exactly:
       menuScene.size = view.bounds.size
       // Show the menu:
       skView.presentScene(menuScene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
