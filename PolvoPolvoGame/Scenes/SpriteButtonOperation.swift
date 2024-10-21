//
//  SpriteButtonOperacao.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 24/01/24.
//


import Foundation
import SpriteKit

// botao de operacao que sera adaptado com o nosso design
class SpriteButtonOperation: SKNode {
    
    var clickAction: () -> Void
    var number: SKLabelNode
    var changeOperation = OperationButton()
    var node: SKSpriteNode
    
    init(action: @escaping () -> Void) {
        clickAction = action
        
        number = SKLabelNode()
        // mostra no botao a selectedOperation
        number.text = "\(changeOperation.selectedOperation.name)"
        number.zPosition = 3
        
        number.fontSize = 28
        number.fontColor = SKColor.white //Cor do botão
        number.fontName = "IstokWeb-Bold"
        
        node = SKSpriteNode(texture: SKTexture(imageNamed: "button2"))
        node.setScale(1/1.08)
        node.zPosition = 2
        
        super.init()
        

        addChild(node)
        addChild(number)
        
        isUserInteractionEnabled = true
        
    }
    
    //ao clicar no botao, o texto do botao troca de acordo com a funcao do changeOperation, que varia entre subtracao e divisao
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        number.text = "\(changeOperation.changeOperation().name)"
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickAction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
