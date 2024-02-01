//
//  StartButton.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 01/02/24.
//

import SpriteKit


//Estilo do botão que é o "jogar", "tutorial", "proximo", "reiniciar" e "finalizar"
class WriteButton {
    let node: SKSpriteNode
    
    init(name: String, text: String) {
        let textNode = SKLabelNode(fontNamed: "Istok Web")
        textNode.text = text
        textNode.fontSize = 28
        textNode.fontColor = SKColor.white
        textNode.verticalAlignmentMode = .center
        textNode.name = name
        
        node = SKSpriteNode(imageNamed: "Button")
        node.name = name
        
        node.addChild(textNode)
    }
    
}
