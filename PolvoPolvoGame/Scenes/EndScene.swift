//
//  EndScene.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 31/01/24.
//

import Foundation
import SpriteKit

//cena de quando o jogador perde o jogo
class EndScene: SKScene {
    
    //instancia a caixa com os dados do final do jogo (que está dentro da EndData)
    var endData: EndData = EndData(points: DataModel.shared.contadorEquacoes, bPoints: 0)
    
    //instancia botão de Reiniciar e Voltar para o Menu
    var reiniciarButton: WriteButton = WriteButton(name: "reiniciarButton", text: "Reiniciar")
    var menuButton: WriteButton = WriteButton(name: "menuButton", text: "Menu")
    
    //instancia o background
    var background = SKSpriteNode(imageNamed: "background")
    
    //instancia o texto acima da caixa
    var label1: WriteNode = WriteNode(name: "label1", fontSize: .labelPoints, text: "Ops!", fontName: .labelPoints)
    var label2: WriteNode = WriteNode(name: "label2", fontSize: .labelPoints, text: "você deicou os pratos cairem.", fontName: <#T##FontesEnum#>)
    
    //instancia os tres pratos quebrados
    var brokenplates = SKSpriteNode(imageNamed: "brokenplates")
    
    override func didMove(to view: SKView) {
        
        //Adiciona a caixa EndData
        endData.node.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(endData.node)
        
        //Adiciona o botão reiniciar
        reiniciarButton.node.position = CGPoint(x: frame.midX, y: frame.midY - 250)
        addChild(reiniciarButton.node)
        
        //Adicionar o botão menu
        menuButton.node.position = CGPoint(x: frame.midX, y: frame.midY - 300)
        addChild(menuButton.node)
        
        //Adiciona o Background
        background.zPosition = CGFloat(-10)
        background.position = CGPoint(x: frame.midX , y: frame.midY)
        addChild(background)
        
        //Adiciona o texto acima da caixa
        label1.node.position = CGPoint(x: frame.midX, y: frame.midY + 300)
        label2.node.position = CGPoint(x: frame.midX, y: frame.midY + 250)
        addChild(label1.node)
        addChild(label2.node)
        
        //Adiciona os tres pratos quebrados
        brokenplates.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(brokenplates)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            //O que indica que quando clicar no startButton vai chamar a função de ir para a cena de jogo
            if touchedNode.name == "reiniciarButton" {
                restartGame()
            }
            
            //O que indica que quando clicar no tutorialButton vai chamar a função de ir para a cena de tutorial
            if touchedNode.name == "menuButton" {
                backMenu()
            }
        }
    }
    
    //função que chama a GameScene
    func restartGame() {
        // Animar botão sendo pressionado
        let newScene = GameScene()
        self.changeTo(scene: newScene)
    }
    
    //função que chama a MenuScene
    func backMenu() {
        let newScene = MenuScene()
        self.changeTo(scene: newScene)
    }
    
    //TODO: Botão de som
}
