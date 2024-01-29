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
    var base: SKShapeNode
    var thumb: SKShapeNode
    var text: SKLabelNode
    var textLabel: String
    var positionButton = CGPoint(x: 230, y: 250)
    
    init(action: @escaping () -> Void, textLabel: String) {
        clickAction = action
        
        text = SKLabelNode()
        self.textLabel = textLabel
        text.text = textLabel
        text.zPosition = 3
        text.fontColor = .black
        text.position = positionButton
        
        base = SKShapeNode(circleOfRadius: 60)
        base.fillColor = .black.withAlphaComponent(0.2)
        base.lineWidth = 0
        base.zPosition = 1
        base.position = positionButton

        
        thumb = SKShapeNode(circleOfRadius: 50)
        thumb.fillColor = .yellow
        thumb.lineWidth = 0
        thumb.zPosition = 2
        thumb.position = positionButton
        
        super.init()
        
        addChild(base)
        addChild(thumb)
        addChild(text)
        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        thumb.run(SKAction.scale(to: 0.7, duration: 0.5))
        print("toqueiii")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        thumb.run(SKAction.scale(to: 1, duration: 0.5))
        clickAction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        thumb.run(SKAction.scale(to: 1, duration: 0.5))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func remove(){
        base.removeAllChildren()
        thumb.removeAllChildren()
        text.removeAllChildren()
    }
}
