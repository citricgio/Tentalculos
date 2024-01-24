//
//  SpriteButton.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 23/01/24.
//

import Foundation
import SpriteKit

// botao de numero que sera adaptado com o nosso design
class SpriteButtonNumbers: SKNode {
    
    var clickAction: () -> Void
    var base: SKShapeNode
    var thumb: SKShapeNode
    var number: SKLabelNode
    var changeNumber = OperationButton()
    var positionButton = CGPoint(x: 300, y: 400)
    
    init(action: @escaping () -> Void) {
        clickAction = action
        
        number = SKLabelNode()
        // mostra no botao a selectedFruit
        number.text = "\(changeNumber.selectedFruit.valor)"
        number.zPosition = 3
        number.fontColor = .black
        number.position = positionButton
        
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
        addChild(number)
        
        self.isUserInteractionEnabled = true
        
    }
    
    //ao clicar no botao, o texto do botao troca de acordo com a funcao do changeNumero, que varia entre 1, 2, 3 e 5
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        thumb.run(SKAction.scale(to: 0.7, duration: 0.5))
        number.text = "\(changeNumber.changeNumber().valor)"
        
//        numeroFruta = mudarNumero.AumentarContador()
//        print(numeroFruta)
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
}
