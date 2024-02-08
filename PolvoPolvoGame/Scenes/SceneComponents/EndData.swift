//
//  StartButton.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 01/02/24.
//

import SpriteKit

//Caixa com as informações no final do jogo para o jogador contendo: Pontuação e Melhor pontuação
//Vai adicionar 4 Node Filhos do Node princial com cada uma funcionalidade: Label1: Adicionar texto escritos e textPoints adicionar variáveis, cada um em uma linha

class EndData {
    let node: SKSpriteNode
    
    init(points: Int, bPoints: Int) {
        let labelFontSize: CGFloat = 24
        let pointsFontSize: CGFloat = 40
        
        let label1 = SKLabelNode(fontNamed: "IstokWeb-Bold") //nome do Node e qual fonte usar
        label1.text = "Pontos" //O que está escrito no Node
        label1.fontSize = labelFontSize //O tamanho da fonte
        label1.fontColor = SKColor.black //A cor da fonte
        label1.verticalAlignmentMode = .center //O alinhamento da fonte
        label1.zPosition = 11
        
        let textPoints = SKLabelNode(fontNamed: "Istok Web")
        textPoints.text = "\(points)"
        textPoints.fontSize = pointsFontSize
        textPoints.fontColor = SKColor.black
        textPoints.verticalAlignmentMode = .center
        textPoints.zPosition = 11

        
        let label2 = SKLabelNode(fontNamed: "IstokWeb-Bold")
        label2.text = "Recorde"
        label2.fontSize = labelFontSize
        label2.fontColor = SKColor.black
        label2.verticalAlignmentMode = .center
        label2.zPosition = 11

        
        let textBPoints = SKLabelNode(fontNamed: "Istok Web")
        textBPoints.text = "\(bPoints)"
        textBPoints.fontSize = pointsFontSize
        textBPoints.fontColor = SKColor.black
        textBPoints.verticalAlignmentMode = .center
        textBPoints.zPosition = 11

        
        
        //Aqui é adicionado a imagem do SquareBox e é adicionado cada texto em sua respectiva posição
        node = SKSpriteNode(imageNamed: "SquareBox")
        let xPos = node.frame.midX //usa como padrão o meio do frame
        let space: CGFloat = 30 //o espaçamento entre as palabras
        textPoints.position = CGPoint(x: xPos, y: textPoints.position.y + (space * 2))
        label1.position = CGPoint(x: xPos, y: node.frame.midY + space)
        label2.position = CGPoint(x: xPos, y: label2.position.y - (space * 2) - 15)
        textBPoints.position = CGPoint(x: xPos, y: node.frame.midY - space - 15)
        
        //Adicionando os nodes
        node.addChild(label1)
        node.addChild(textPoints)
        node.addChild(label2)
        node.addChild(textBPoints)
    }
    
}
