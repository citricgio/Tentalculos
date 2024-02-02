//
//  SKScene+.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 31/01/24.
//

import SpriteKit

extension SKScene {
    func changeTo(scene: SKScene) {
        let reveal = SKTransition.fade(withDuration: 1)
        scene.size = self.size
        scene.scaleMode = .aspectFill
        self.scene?.view?.presentScene(scene,
                                       transition: reveal)
    }
}
