//
//  WriteNode.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 01/02/24.
//

import SpriteKit

//Um node para escrever texto dentro das cenas
class WriteNode {
    let node: SKNode
    
    init(name: String, fontSize: CGFloat, text: String, fontName: String) {
        let textNode = SKLabelNode(fontNamed: fontName) //qual fonte usar
        textNode.text = text //Texto que vai dentro do node, que é uma variável recebida quando o Node é chamado
        textNode.fontSize = fontSize //Tamanho do texto que vai dentro do node
        textNode.fontColor = SKColor.white //Cor do texto
        textNode.verticalAlignmentMode = .center //o alinhamento do texto dentro do Node
        textNode.name = name //recebe o nome do Node, que é recebido quando o Node é chamado
        
        node = SKNode()
        node.name = name //Fala p nome do Node
        
        node.addChild(textNode)
    }
}
