//
//  GameSprite.swift
//  game1
//
//  Created by Viktor Kirillov on 11/24/19.
//  Copyright © 2019 Viktor Kirillov. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
