//
//  SpriteButton.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 23/01/24.
//

import Foundation
import SpriteKit

class SpriteButtonReduce: SKNode {
    
    var clickAction: () -> Void
    var text: SKLabelNode
    var textLabel: String
    var node: SKSpriteNode
    
    init(action: @escaping () -> Void, textLabel: String) {
        clickAction = action
        
        text = SKLabelNode()
        self.textLabel = textLabel
        text.text = textLabel
        text.zPosition = 3
        
        text.fontSize = 28
        text.verticalAlignmentMode = .center
        text.fontColor = SKColor.white //Cor do botão
        text.fontName = "IstokWeb-Bold"
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "button3"))
        node.setScale(1/1.08)
        node.zPosition = 2
        
        super.init()
        
        addChild(text)
        addChild(node)
        
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("toqueiii")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickAction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func remove(){
        text.removeAllChildren()
    }
}
