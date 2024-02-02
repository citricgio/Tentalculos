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
    
    init(name: String, fontSize: FontesEnum, text: String, fontName: FontesEnum) {
        let textNode = SKLabelNode(fontNamed: fontName.font) //qual fonte usar utilizando o FontesEnum
        textNode.text = text //Texto que vai dentro do node, que é uma variável recebida quando o Node é chamado
        textNode.fontSize = fontSize.size //Tamanho do texto que vai dentro do node utilizando o FontesEnum
        textNode.fontColor = SKColor.white //Cor do texto
        textNode.verticalAlignmentMode = .center //o alinhamento do texto dentro do Node
        textNode.name = name //recebe o nome do Node, que é recebido quando o Node é chamado
        
        node = SKNode()
        node.name = name //Fala o nome do Node
        
        node.addChild(textNode)
    }
}
