//
//  MenuScene.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 31/01/24.
//


import SpriteKit

class  MenuScene: SKScene {
    
    var startButton: WriteButton = WriteButton(name: "startButton", text: "Iniciar")
    var tutorialButton: WriteButton = WriteButton(name: "tutorialButton", text: "Tutorial")
    
    override func didMove(to view: SKView) {
        
        startButton.node.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(startButton.node)
        
        tutorialButton.node.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(tutorialButton.node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "startButton" {
                startGame()
            }
        }
    }
    
    func startGame() {
        // Animar botão sendo pressionado
        let newScene = GameScene()
        self.changeTo(scene: newScene)
    }
    
}
