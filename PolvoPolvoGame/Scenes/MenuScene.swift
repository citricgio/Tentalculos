//
//  MenuScene.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 31/01/24.
//


import SpriteKit
import GameKit

//cena de quando o jogador abre o jogo
class  MenuScene: SKScene {
    
    var dataModel: DataModel?
    
    //botões de Jogar e Tutorial
    var startButton: WriteButton = WriteButton(name: "startButton", text: "Jogar")
    var tutorialButton: WriteButton = WriteButton(name: "tutorialButton", text: "Tutorial")
    
    //Instancia Sprite do polvo
    var octopus: SKSpriteNode = SKSpriteNode(imageNamed: "octopus-full")
    
    //instancia background
    var background = SKSpriteNode(imageNamed: "background")
    
    //instancia botão de som e coloca sua imagem
    var soundButton: SKSpriteNode = SKSpriteNode(imageNamed: "SoundButton")
    
    //instancia título do jogo
    var title: WriteNode = WriteNode(name: "title", fontSize: .appTitle, text: "Nome do Jogo", fontName: .appTitle)
    
    //instancia texto da melhor pontuação e a pontuação
    var bPoint: WriteNode = WriteNode(name: "bPoint", fontSize: .points, text: "\(DataModel.shared.points.score)", fontName: .points)
    var labelPoint: WriteNode = WriteNode(name: "labelPoint", fontSize: .labelPoints, text: "Sua melhor pontuação", fontName: .labelPoints )
    
    override func didMove(to view: SKView) {
        
        //Adiciona o botão de Jogar e sua Posição
        startButton.node.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        startButton.node.setScale(1/1.08)
        addChild(startButton.node)
        
        //Adiciona o botão de Tutorial e sua posição
        tutorialButton.node.position = CGPoint(x: frame.midX, y: frame.midY - 250)
        tutorialButton.node.setScale(1/1.08)
        addChild(tutorialButton.node)
        
        //Adiciona o polvo e sua posição
        octopus.size = CGSize(width: 330, height: 253)
        octopus.position = CGPoint(x: frame.midX, y: frame.size.height / 1.89 )
        octopus.setScale(1/1.08)
        addChild(octopus)
        
        //Adiciona o Background e sua posição
        background.zPosition = CGFloat(-10)
        background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        addChild(background)
        
        //Adiciona o texto e a maior pontuação e suas posições
        bPoint.node.position = CGPoint(x: frame.midX  , y: frame.midY + 170)
        labelPoint.node.position = CGPoint(x: frame.midX , y: frame.midY + 200)
        bPoint.node.setScale(1/1.08)
        labelPoint.node.setScale(1/1.08)
        addChild(bPoint.node)
        addChild(labelPoint.node)
        
        //Adiciona o Título
        title.node.position = CGPoint(x: frame.midX, y: frame.midY + 250)
        title.node.setScale(1/1.08)
        addChild(title.node)
        
        //funções de ligadas ao GameCenter que vem do GameCenterController
        GameCenterController.shared.authenticateGameCenter()
        GameCenterController.shared.loadData { data in
            DataModel.shared.points = data
        }
        GameCenterController.shared.accessBestScore()
        
        //Som
            playSound(sound: "Menu", type: "mp3")
        soundButton.position = CGPoint(x: frame.midX + 160, y: frame.midY + 320)
        addChild(soundButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            //O que indica que quando clicar no startButton vai chamar a função de ir para a cena de jogo
            if touchedNode.name == "startButton" {
                startGame()
//                playSound(sound: "Jogo", type: "mp3")

            }
            
            //O que indica que quando clicar no tutorialButton vai chamar a função de ir para a cena de tutorial
            if touchedNode.name == "tutorialButton" {
                startTutorial()
            }
            
            if touchedNode.name == "soundButton" {
                soundIsOn()
                print(DataModel.shared.soundIsOn)
            }
        }
    }
    
    //função que chama a GameScene
    func startGame() {
        // Animar botão sendo pressionado
        DataModel.shared.equationCount = 0
        DataModel.shared.countsLive = 0
        DataModel.shared.isAlive = [true,true,true]

        let newScene = GameScene()
        self.changeTo(scene: newScene)
        playSound(sound: "Jogo", type: "mp3")
    }
    
    //função que Chama a TutorialScene
    func startTutorial() {
        let newScene = EndScene()
        self.changeTo(scene: newScene)
        playSound(sound: "Jogo", type: "mp3")
    }
    //TODO: adicionar o botão de som, fazer funcionar e mudar ele
    func soundIsOn() {
        DataModel.shared.soundIsOn.toggle()
    }
    
//    func createSound(){
//        soundButton = SKSpriteNode(imageNamed: DataModel.shared.soundIsOn ? "SoundButton" : "SoundOff")
//        soundButton.position = CGPoint(x: frame.size.width / 10, y: frame.size.height / 5)
//        addChild(soundButton)
//    }
    
   
}
