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
    
//    var dataModel: DataModel?
    
    //botões de Jogar e Tutorial
    var startButton: WriteButton = WriteButton(name: "startButton", text: "Jogar")
    var tutorialButton: WriteButton = WriteButton(name: "tutorialButton", text: "Tutorial")
    
    //Instancia Sprite do polvo
    var octopus: SKSpriteNode = SKSpriteNode(imageNamed: "octopus-full")
    
    var trayLeft: SKSpriteNode = SKSpriteNode(imageNamed: "tray")
    var trayRight: SKSpriteNode = SKSpriteNode(imageNamed: "tray")

    
    //instancia background
    var background = SKSpriteNode(imageNamed: "background")
    
    //instancia botão de som e coloca sua imagem
    var soundButton: SKSpriteNode = SKSpriteNode(imageNamed: "SoundButton")
    
    //instancia título do jogo
    var title: WriteNode = WriteNode(name: "title", fontSize: .appTitle, text: "Nome do Jogo", fontName: .appTitle)
    
    //instancia texto da melhor pontuação e a pontuação
    var bPoint: WriteNode = WriteNode(name: "bPoint", fontSize: .points, text: "\(DataModel.shared.points.score)", fontName: .points)
    var labelPoint: WriteNode = WriteNode(name: "labelPoint", fontSize: .labelPoints, text: "Sua melhor pontuação", fontName: .labelPoints )
    
    var logoName: SKSpriteNode = SKSpriteNode(imageNamed: "logo")
    var crown: SKSpriteNode = SKSpriteNode(imageNamed: "crown")
    
    var gameSound: SKAudioNode = SKAudioNode()
    
    override func didMove(to view: SKView) {
        
        gameSound = SKAudioNode(fileNamed: "Menu")
        addChild(gameSound)
        
        //Adiciona o botão de Jogar e sua Posição
        startButton.node.position = CGPoint(x: frame.midX, y: frame.size.height / 3.45)
        startButton.node.setScale(1/1.08)
        addChild(startButton.node)
        
        //Adiciona o botão de Tutorial e sua posição
        tutorialButton.node.position = CGPoint(x: frame.midX, y: frame.midY - frame.size.height / 3.45)
        tutorialButton.node.setScale(1/1.08)
        addChild(tutorialButton.node)
        
        
        logoName.position = CGPoint(x: size.width / 2, y: frame.size.height / 1.136)
        logoName.size = CGSize(width: frame.size.width / 0.95, height: frame.size.height / 3.27)
        addChild(logoName)
        //Adiciona o polvo e sua posição
        octopus.size = CGSize(width: frame.size.width / 1.30, height: frame.size.height / 3.68)
        octopus.position = CGPoint(x: frame.midX - frame.size.width / 21.5, y: frame.size.height / 2.02 )
        octopus.setScale(1/1.08)
        addChild(octopus)
        
        trayLeft.size = CGSize(width: frame.size.width / 2.86, height: frame.size.height / 37.28)
        trayLeft.position = CGPoint(x: frame.size.width / 5.7, y: frame.size.height / 1.75)
        trayLeft.zPosition = 40
        addChild(trayLeft)
        
        trayRight.size = CGSize(width: frame.size.width / 2.86, height: frame.size.height / 37.28)
        trayRight.position = CGPoint(x: frame.size.width / 1.23, y: frame.size.height / 1.75)
        trayRight.zPosition = 40
        addChild(trayRight)
        
        //Adiciona o Background e sua posição
        background.zPosition = CGFloat(-10)
        background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        addChild(background)
        
        //Adiciona o texto e a maior pontuação e suas posições
        bPoint.node.position = CGPoint(x: frame.midX  , y: frame.midY + frame.size.height / 5.54)
        bPoint.node.setScale(1.5)
        addChild(bPoint.node)
        
        crown.position = CGPoint(x: frame.midX + frame.size.width / 28.66 , y: frame.midY + frame.size.height / 4.77)
        addChild(crown)

        //funções de ligadas ao GameCenter que vem do GameCenterController
        GameCenterController.shared.authenticateGameCenter()
        GameCenterController.shared.loadData { data in
            DataModel.shared.points = data
        }
        
        //Som
        soundButton.position = CGPoint(x: frame.midX + frame.size.width / 2.45, y: frame.midY + frame.size.height / 2.33)
        soundButton.name = "soundButton"
        soundButton.size = CGSize(width: frame.size.width / 7.16, height: frame.size.height / 15.5)
       addChild(soundButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if DataModel.shared.soundIsOn {
            let texture = SKTexture(imageNamed: "SoundButton")
            let action = SKAction.setTexture(texture)
            gameSound.run(SKAction.play())
            soundButton.run(action)
        }
        else {
            let texture = SKTexture(imageNamed: "SoundOffButton")
            let action = SKAction.setTexture(texture)
            gameSound.run(SKAction.stop())
            soundButton.run(action)
        }
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
    }
    
    //função que Chama a TutorialScene
    func startTutorial() {
        DataModel.shared.tutorial.toggle()
        if DataModel.shared.soundIsOn {
            let action = SKAction.playSoundFileNamed("Jogo", waitForCompletion: true)
            run(action)
        }
    }

    func soundIsOn() {
        DataModel.shared.soundIsOn.toggle()
        print("som: \(DataModel.shared.soundIsOn)")
    }
    

    
   
}
