//
//  SpriteButton.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 23/01/24.
//

import Foundation
import SpriteKit

class NextButton: SKNode {
    
    var clickAction: () -> Void
    var text: SKLabelNode
    var textLabel: String
    var positionButton = CGPoint(x: 216, y: 70)
    var node: SKSpriteNode

    
    init(action: @escaping () -> Void, textLabel: String) {
        clickAction = action
        
        text = SKLabelNode()
        self.textLabel = textLabel
        text.text = self.textLabel
        text.zPosition = 3
        text.fontColor = .black
        text.position = positionButton
        text.fontSize = 28
        text.verticalAlignmentMode = .center
        text.fontColor = SKColor.white //Cor do botão
        text.fontName = "IstokWeb-Bold"
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "Button"))
        node.position = positionButton
        node.name = textLabel
        node.setScale(1/1.08)
        node.zPosition = 2

        super.init()

        
        self.addChild(text)
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
    
    func remove(){
        text.removeAllChildren()
    }
}
