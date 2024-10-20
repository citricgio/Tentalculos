//
//  SettingsButton.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Micher on 20/10/24.
//

import Foundation
import SpriteKit

class SettingsButton: SKNode {
    
    var clickAction: () -> Void
    var node: SKSpriteNode

    
    init(action: @escaping () -> Void) {
        clickAction = action
        
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "ajustes"))
        node.setScale(1/1.08)
        node.zPosition = 40

        super.init()

        self.addChild(node)

        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
