//
//  SpriteButton.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 23/01/24.
//

import Foundation
import SpriteKit

class RestartButton: SKNode {
    
    var clickAction: () -> Void
    var positionButton = CGPoint(x: 340, y: 400)
    var node: SKSpriteNode

    
    init(action: @escaping () -> Void) {
        clickAction = action
        
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "Button"))
        node.position = positionButton
        node.setScale(1/1.08)
        node.zPosition = 40

        super.init()

        self.addChild(node)

        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("toqueiii")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
