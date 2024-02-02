//
//  StartButton.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 01/02/24.
//

import SpriteKit


//Estilo do botão que é o "jogar", "tutorial", "proximo", "reiniciar" e "finalizar"
//Para a utilização é necessário colocar o nome e o que vai ser escrito nos parametros, cada vez adicionado com um nome diferente é adicionado botão diferente ao que você pode atribuir uma função

class WriteButton {
    let node: SKSpriteNode
    
    init(name: String, text: String) {
        let textNode = SKLabelNode(fontNamed: "IstokWeb-Bold") //qual fonte usar
        textNode.text = text //Texto que vai dentro do botão, que é uma variável recebida quando o Node é chamado
        textNode.fontSize = 28 //Tamanho do texto que vai dentro do botão
        textNode.fontColor = SKColor.white //Cor do botão
        textNode.verticalAlignmentMode = .center //o alinhamento do texto dentro do Node
        textNode.name = name //recebe o nome do Node, que é recebido quando o Node é chamado
        
        node = SKSpriteNode(imageNamed: "Button")
        node.name = name //Fala p nome do Node
        
        node.addChild(textNode)
    }
    
}
