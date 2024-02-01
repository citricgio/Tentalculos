//
//  StartButton.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 01/02/24.
//

import SpriteKit

//Caixa com as informações no final do jogo para o jogador contendo: Pontuação e Melhor pontuação
class EndData {
    let node: SKSpriteNode
    
    init(points: Int, bPoints: Int) {
        let labelFontSize: CGFloat = 24
        let pointsFontSize: CGFloat = 32
        
        let label1 = SKLabelNode(fontNamed: "IstokWeb-Bold")
        label1.text = "Pontuação"
        label1.fontSize = labelFontSize
        label1.fontColor = SKColor.white
        label1.verticalAlignmentMode = .center
        
        let textPoints = SKLabelNode(fontNamed: "Istok Web")
        textPoints.text = "\(points)"
        textPoints.fontSize = pointsFontSize
        textPoints.fontColor = SKColor.white
        textPoints.verticalAlignmentMode = .center
        
        let label2 = SKLabelNode(fontNamed: "IstokWeb-Bold")
        label2.text = "Sua Melhor Pontuação"
        label2.fontSize = labelFontSize
        label2.fontColor = SKColor.white
        label2.verticalAlignmentMode = .center
        
        let textBPoints = SKLabelNode(fontNamed: "Istok Web")
        textBPoints.text = "\(bPoints)"
        textBPoints.fontSize = pointsFontSize
        textBPoints.fontColor = SKColor.white
        textBPoints.verticalAlignmentMode = .center
        
        
        
        node = SKSpriteNode(imageNamed: "SquareBox")
        let xPos = node.frame.midX
        let space: CGFloat = 20
        textPoints.position = CGPoint(x: xPos, y: node.frame.midY + space)
        label1.position = CGPoint(x: xPos, y: textPoints.position.y + (space * 2))
        label2.position = CGPoint(x: xPos, y: node.frame.midY - space)
        textBPoints.position = CGPoint(x: xPos, y: label2.position.y - (space * 2))
        
        node.addChild(label1)
        node.addChild(textPoints)
        node.addChild(label2)
        node.addChild(textBPoints)
    }
    
}
