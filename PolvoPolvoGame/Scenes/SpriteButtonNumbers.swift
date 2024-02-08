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
    var number: SKLabelNode
    var changeNumber = OperationButton()
    var positionButton = CGPoint(x: 220, y: 240)
    var node: SKSpriteNode
    
    init(action: @escaping () -> Void) {
        clickAction = action
        
        number = SKLabelNode()
        // mostra no botao a selectedFruit
        number.text = "\(changeNumber.selectedFruit.value)"
        number.zPosition = 3
        number.position = positionButton
        number.fontSize = 28
        number.verticalAlignmentMode = .center
        number.fontColor = SKColor.white //Cor do botão
        number.fontName = "IstokWeb-Bold"
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "button2"))
        node.position = positionButton
        node.setScale(1/1.08)
        node.zPosition = 2

        super.init()

        self.addChild(number)
        self.addChild(node)
        
        isUserInteractionEnabled = true
                
    }
    
    //ao clicar no botao, o texto do botao troca de acordo com a funcao do changeNumero, que varia entre 1, 2, 3 e 5
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        number.text = "\(changeNumber.changeNumber().value)"
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickAction()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
