//
//  GameViewController.swift
//  SceneKitGame
//
//  Created by Viktor Kirillov on 11/25/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var gameSCNScene: GameSCNScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scnView = view as! SCNView
        gameSCNScene = GameSCNScene(currentview: scnView)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
