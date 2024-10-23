// GameScene.swift
// BluebinProject
//
// Created by Giovanna Micher on 19/01/24.
//
import GameKit
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    
    // instância do enum, para pegar a imagem e o valor de cada fruta
    var food: FruitNode = FruitNode(fruit: .fruit1)
    
    // instância de GeradorPesos para gerar uma equacão aleatória
    var gerador: EquationGenerator = EquationGenerator()
    
    // instância de BalancaDados para adicionar e travar os itens na balança
    var balanca: DataBalance = DataBalance()
    
    // instância de comida
    //var foodNode = SKSpriteNode()
    
    // arrays que armazenam a quantidade de comida em cada bandeja
    var foodArrayLeft: [FruitNode] = []
    var foodArrayRight: [FruitNode] = []
    
    // contador de quantas posições a fruta adicionada vai andar
    var foodContLeft: CGFloat = 0
    var foodContRight: CGFloat = 0
    
    // bandejas de comida
    let foodInvisibleFrameLeft = SKSpriteNode()
    let foodInvisibleFrameRight = SKSpriteNode()
    
    let foodTrayLeft = SKSpriteNode()
    let foodTrayRight = SKSpriteNode()
    
    // variáveis que armazenam o local da posição da bandeja de quando rotaciona o braço do polvo
    var trayPositionUpY: CGFloat = 0 //553
    var trayPositionDownY: CGFloat = 0 //495
    
    // variáveis que indicam se tem comida na bandeja ou não
    var isInTrayLeft: Bool = false
    var isInTrayRight: Bool = false
    
    // braço do polvo
    let octopusArm = SKSpriteNode()
    
    let octopusBody = SKSpriteNode()
    
    let octopusFace = SKSpriteNode()
    
    // spawners da onde saem as comidas
    let spawner1 = SKSpriteNode()
    let spawner2 = SKSpriteNode()
    let spawner3 = SKSpriteNode()
    let spawner5 = SKSpriteNode()
    let spawnerIncognita = SKSpriteNode()
    let shelf = SKSpriteNode()
    let shelf2 = SKSpriteNode()
    
    var foodRemovedArray: [SKSpriteNode] = []
    
    // variável que indica o ângulo dos braços do polvo
    var angle: CGFloat = 0
    
    var isCorrect: Bool = false
    
    var nextButton: NextButton = NextButton(action: {}, textLabel: "Próximo")
    
    var restartButton: RestartButton = RestartButton(action: {})
    
    var settingsButton: SettingsButton = SettingsButton(action: {})
    
    var operationButton: SpriteButtonOperation = SpriteButtonOperation(action: {})
    
    var operationNumbersButton: SpriteButtonNumbers = SpriteButtonNumbers(action: {})
    
    var irButton: SpriteButtonReduce = SpriteButtonReduce(action: {}, textLabel: "Ir")
    
    var isButtonAdded: Bool = false
    
    var background = SKSpriteNode(imageNamed: "background")
    
    var changeOperation = OperationButton()
    
    var calculator = Calculator()
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var bestScore = 0
    
    
    var live1 = SKSpriteNode()
    var live2 = SKSpriteNode()
    var live3 = SKSpriteNode()
    var lives: [SKSpriteNode] = []
    
    var brokenPlate = SKTexture(imageNamed: "broken-plate")
    var plate = SKTexture(imageNamed: "normal-plate")
    
    var lineEquation = SKSpriteNode(imageNamed: "line")
    var equationLabel = SKLabelNode()
    
    var popupNode: SKShapeNode!
    
    var gameSound: SKAudioNode = SKAudioNode()
        
    let soundButton = SKSpriteNode(imageNamed: "SoundButton")
        
    // função que carrega as coisas na tela (quando a cena do sprite kit é movida para a tela)
    override func didMove(to view: SKView) {
        
        
        print(frame.size.width)
        print(frame.size.height)
        
        let food1 = setupTextLabelNumbers(fruit: .fruit1)
        foodRemovedArray.append(food1)
        
        let food2 = setupTextLabelNumbers(fruit: .fruit2)
        foodRemovedArray.append(food2)
        
        let food3 = setupTextLabelNumbers(fruit: .fruit3)
        foodRemovedArray.append(food3)
        
        let food5 = setupTextLabelNumbers(fruit: .fruit5)
        foodRemovedArray.append(food5)
        
        let incognita = setupTextLabelNumbers(fruit: .unknown)
        foodRemovedArray.append(incognita)
        
        DataModel.shared.weightRightSide = 0
        DataModel.shared.weightLeftSide = 0
        isInTrayLeft = false
        isInTrayRight = false
        DataModel.shared.hasX = false
        foodArrayLeft.removeAll()
        foodArrayRight.removeAll()
        DataModel.shared.leftBalanceLocked = false
        DataModel.shared.rightBalanceLocked = false
        isCorrect = false
        
        trayPositionUpY = frame.size.height / 1.68
        trayPositionDownY = frame.size.height / 1.88
        
        setupGame()
        setupSpawners()
        setupArm()
        setupTargets()
        
        nextButton = NextButton(action: isCorrect ? finalizeCheck : firstCheck, textLabel: isCorrect ? "Concluir" : "Próximo")
        nextButton.text.position = CGPoint(x: frame.midX - 4, y: frame.size.height / 13.31)
        nextButton.node.position = CGPoint(x: frame.midX, y: frame.size.height / 13.31)
        
        addChild(nextButton)
        
        settingsButton = SettingsButton(action: showPopup)
        settingsButton.setScale(0.9)
        settingsButton.position = CGPoint(x: frame.size.width / 1.102, y: frame.size.height / 1.08)
        
        addChild(settingsButton)
        
        restartButton = RestartButton(action: restartFood)
        restartButton.position = CGPoint(x: frame.size.width / 1.102, y: frame.size.height / 1.179)
        
        addChild(restartButton)
        
        background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        addChild(background)
        
        addScore()
        addLives()
        addEquation()
        
    }
    
    func addOperationButtons() {
        operationNumbersButton = SpriteButtonNumbers(){
        }
        operationNumbersButton.number.position = CGPoint(x: frame.midX - 1, y: frame.size.height / 4.7)
        operationNumbersButton.node.position = CGPoint(x: frame.midX, y: frame.size.height / 4.6)
        addChild(operationNumbersButton)
        
        irButton = SpriteButtonReduce(action: reduceFood, textLabel: "Ir")
        irButton.text.position = CGPoint(x: frame.midX + 100, y: frame.size.height / 4.6)
        irButton.node.position = CGPoint(x: frame.midX + 100, y: frame.size.height / 4.6)
        addChild(irButton)
        
        operationButton = SpriteButtonOperation() {
            //print("cliquei")
        }
        operationButton.number.position = CGPoint(x: frame.midX - 92, y: frame.size.height / 4.9)
        operationButton.node.position = CGPoint(x: frame.midX - 90, y: frame.size.height / 4.6)
        addChild(operationButton)
        
    }
    
    func addEquation() {
        
        lineEquation.zPosition = 20
        lineEquation.position = CGPoint(x: size.width/2, y: frame.size.height / 1.295)
        lineEquation.size = CGSize(width: frame.size.width / 0.74, height: frame.size.height / 7.45)
        
        EquationGenerator().assembleEquation()
        equationLabel.zPosition = 21
        equationLabel.fontColor = .black
        equationLabel.position = CGPoint(x: size.width/2 + frame.size.width / 43, y: frame.size.height / 1.36)
        equationLabel.text = DataModel.shared.equationText
        equationLabel.fontName = "IstokWeb-Bold"
        equationLabel.fontSize = 27
        
        addChild(lineEquation)
        addChild(equationLabel)
    }
    
    
    func updateEquation() {
        equationLabel.text = "X = \(DataModel.shared.valueX)"
        equationLabel.fontColor = .systemGreen
    }
    
    // adicionar a label dos pontos na tela
    func addScore() {
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: size.width / 2, y: frame.size.height / 1.105)
        scoreLabel.fontName = "IstokWeb-Bold"
        scoreLabel.fontSize = 24
        
        addChild(scoreLabel)
    }
    
    // fazer o update dos pontos
    func updateScore() {
        DataModel.shared.equationCount += 1
    }
    
    // adicionar as vidas na tela e adiciona-las numa array com todas as vidas
    func addLives() {
        
        live1 = SKSpriteNode(texture: plate)
        live1.position = CGPoint(x: size.width / 2 - frame.size.width / 6.82, y: frame.size.height / 1.179)
        live1.zPosition = 11
        live1.name = "live1"
        live1.size = CGSize(width: frame.size.width / 7.54, height: frame.size.height / 16.35)
        print("VIDA 1")
        
        if DataModel.shared.isAlive[0] == false {
            live1.texture = brokenPlate
            addChild(live1)
            lives.append(live1)
        }
        else {
            addChild(live1)
            lives.append(live1)
        }
        
        live2 = SKSpriteNode(texture: plate)
        live2.position = CGPoint(x: size.width / 2, y: frame.size.height / 1.179)
        live2.zPosition = 11
        live2.name = "live2"
        live2.size = CGSize(width: frame.size.width / 7.54, height: frame.size.height / 16.35)
        
        print("VIDA 2")
        
        if DataModel.shared.isAlive[1] == false {
            live2.texture = brokenPlate
            addChild(live2)
            lives.append(live2)
        }
        else {
            addChild(live2)
            lives.append(live2)
        }
        
        
        
        live3 = SKSpriteNode(texture: plate)
        live3.position = CGPoint(x: size.width / 2 + frame.size.width / 6.82, y: frame.size.height / 1.179)
        live3.zPosition = 11
        live3.name = "live3"
        live3.size = CGSize(width: frame.size.width / 7.54, height: frame.size.height / 16.35)
        
        print("VIDA 3")
        
        if DataModel.shared.isAlive[2] == false {
            live3.texture = brokenPlate
            addChild(live3)
            lives.append(live3)
        }
        else {
            addChild(live3)
            lives.append(live3)
        }
        
    }
    
    // muda o estado do prato para quebrado
    func updateLives() {
        // passa pelo array de vidas
        for i in 0...lives.count - 1 {
            // se a posicao daquela vida se tornar falsa porque o jogador perdeu, pega a vida que está naquela posicao e troca a imagem para brokenPlate
            if DataModel.shared.isAlive[i] == false {
                let live = lives[i]
                live.texture = brokenPlate
                
            }
        }
    }
    
    func setupParabens() {
        let node = SKSpriteNode()
        node.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let parabens = SKTexture(imageNamed: "parabens")
        let action1 = SKAction.setTexture(parabens, resize: true)
        let fade = SKAction.fadeOut(withDuration: 1)
        
        let sequence = SKAction.sequence([action1,fade])
        node.run(sequence)
    }
    
    func endGame() {
        //pega a primeira vida e confirma se a posicao dela é verdadeira
        if childNode(withName: "live1") != nil && DataModel.shared.isAlive[0] == true {
            // muda a sua posicao para falso, chama a funcao updateLives() e aumenta o contador que acompanha a quantidade de vidas que o jogador tem
            DataModel.shared.isAlive[0] = false
            print("errouuuuu1")
            updateLives()
            DataModel.shared.countsLive += 1
            print("oiiii \(DataModel.shared.countsLive)")
            
            if DataModel.shared.isSoundActivated {
                let action = SKAction.playSoundFileNamed("Prato", waitForCompletion: true)
                run(action)
            }
            
            
            let textureMid = SKTexture(imageNamed: "mid-face")
            let textureHappy = SKTexture(imageNamed: "happy-face")
            let action1 = SKAction.setTexture(textureMid, resize: true)
            let actionWait = SKAction.wait(forDuration: 1.5)
            let action2 = SKAction.setTexture(textureHappy, resize: true)
            
            let sequence = SKAction.sequence([action1,actionWait,action2])
            octopusFace.run(sequence)
        }
        else if childNode(withName: "live2") != nil && DataModel.shared.isAlive[1] == true {
            DataModel.shared.isAlive[1] = false
            print("errouuuuu2")
            updateLives()
            DataModel.shared.countsLive += 1
            print("oiiii \(DataModel.shared.countsLive)")
            
            if DataModel.shared.isSoundActivated {
                let action = SKAction.playSoundFileNamed("Prato", waitForCompletion: true)
                run(action)
            }
            
            let textureSad = SKTexture(imageNamed: "sad-face")
            let textureHappy = SKTexture(imageNamed: "happy-face")
            let action1 = SKAction.setTexture(textureSad, resize: true)
            let actionWait = SKAction.wait(forDuration: 1.5)
            let action2 = SKAction.setTexture(textureHappy, resize: true)
            
            let sequence = SKAction.sequence([action1,actionWait,action2])
            octopusFace.run(sequence)
            
        }
        else if childNode(withName: "live3") != nil && DataModel.shared.isAlive[2] == true {
            DataModel.shared.isAlive[2] = false
            print("errouuuuu3")
            updateLives()
            DataModel.shared.countsLive += 1
            print("oiiii \(DataModel.shared.countsLive)")
            
            if DataModel.shared.isSoundActivated {
                let action = SKAction.playSoundFileNamed("Prato", waitForCompletion: true)
                run(action)
            }
            
        }
        // se o contador de vidas chegar a 3, muda para a tela final de perder o jogo
        if DataModel.shared.countsLive == 3 {
            if DataModel.shared.equationCount > DataModel.shared.points.score {
                DataModel.shared.points.score = DataModel.shared.equationCount
                Task {
                    await GameCenterController.shared.SaveData(gameplayData: DataModel.shared.points)
                }
            }
            let endGameScene = EndScene()
            self.changeTo(scene: endGameScene)
        }
    }
    
    
    func firstCheck() {
        if DataModel.shared.rightBalanceLocked && DataModel.shared.leftBalanceLocked && DataModel.shared.hasX {
            //desespawnar e mostra botao de operacoes
            print("ACERTOUUU")
            isCorrect = true
            nextButton.text.text = "Concluir"
            removeChildren(in: [spawner1, spawner2, spawner3, spawner5, spawnerIncognita])
            removeChildren(in: foodRemovedArray)
            addOperationButtons()
            updateScore()
            nextButton.clickAction = finalizeCheck
            
            let shelfTexture = SKTexture(imageNamed: "shelf2")
            let action1 = SKAction.setTexture(shelfTexture, resize: true)
            
            shelf.setScale(0.87)
            shelf.position = CGPoint(x: frame.midX, y: frame.minY + frame.size.height / 16)
            
            //shelf.position.y = CGFloat(50)
            
            shelf.run(action1)
            
            //arrumar
            setupParabens()
            removeChildren(in: [restartButton])
            
            
        } else {
            endGame()
            
        }
    }
    
    
    func finalizeCheck(){
        if DataModel.shared.weight == DataModel.shared.valueX {
            DataModel.shared.difficultyCounter += 1
            updateEquation()
            updateScore()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                let GameScene = GameScene()
                self.changeTo(scene: GameScene)
            }
        }
        else{
            endGame()
        }
    }
    
    // função que faz as bases iniciais do jogo
    func setupGame(){
        if DataModel.shared.difficultyCounter <= 3{
            print("contador: \(DataModel.shared.difficultyCounter)")
            gerador.generateBasicEquation() // gera uma equação aleatória
        }
        else {
            gerador.generateIntermidiateEquation()
        }
    }
    
    
    // função que calcula o ângulo de rotação do braço do polvo (vai de -45º até 45º)
    func calculateAngle() {
        if DataModel.shared.weightLeftSide < DataModel.shared.weightRightSide{
            angle = -(.pi / 15)
            
        } else if DataModel.shared.weightLeftSide == DataModel.shared.weightRightSide {
            angle = 0
            
        } else {
            angle = .pi / 15
        }
    }
    
    func showPopup() {
        // Create a semi-transparent background for the popup
        let backgroundNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: self.size)
        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundNode.zPosition = 21
        backgroundNode.name = "popupBackground"
        
        // Create the actual popup
        
        popupNode = SKShapeNode(rectOf: CGSize(width: 250, height: 280), cornerRadius: 20)
        let popupColor = UIColor(named: "popupColor") ?? .white
        popupNode.fillColor = popupColor
        popupNode.position = CGPoint(x: frame.midX, y: frame.midY)
        popupNode.zPosition = 22
        popupNode.name = "popup"
        
        // Add a close button to the popup
        let closeButton = SKSpriteNode(imageNamed: "closeButton")
        closeButton.position = CGPoint(x: popupNode.frame.size.height / 3, y: popupNode.frame.size.height / 2.7)
        closeButton.name = "closePopup"
        popupNode.addChild(closeButton)
        
        soundButton.position = CGPoint(x: 0, y: popupNode.frame.size.height / 4.5)
        soundButton.name = "soundButton"
        soundButton.size = CGSize(width: frame.size.width / 7.16, height: frame.size.height / 15.5)
        popupNode.addChild(soundButton)
        
        // Add label "Som" below the sound button
        let soundLabel = SKLabelNode(text: "Som")
        soundLabel.fontName = "IstokWeb-Bold"
        soundLabel.fontSize = 18
        soundLabel.fontColor = .white
        soundLabel.position = CGPoint(x: 0, y: soundButton.position.y - (soundButton.size.height / 2) - 20)
        popupNode.addChild(soundLabel)
        
        // Add the menu button, positioned below the sound button
        let menuButton = SKSpriteNode(imageNamed: "menuButton")
        menuButton.position = CGPoint(x: 0, y: -popupNode.frame.size.height / 6.3)
        menuButton.name = "menuButton"
        menuButton.size = CGSize(width: frame.size.width / 7.16, height: frame.size.height / 15.5)
        popupNode.addChild(menuButton)
        
        // Add label "Menu" below the menu button
        let menuLabel = SKLabelNode(text: "Menu")
        menuLabel.fontName = "IstokWeb-Bold"
        menuLabel.fontSize = 18
        menuLabel.fontColor = .white
        menuLabel.position = CGPoint(x: 0, y: menuButton.position.y - (menuButton.size.height / 2) - 20)
        popupNode.addChild(menuLabel)
        // Add the popup to the scene
        addChild(backgroundNode)
        addChild(popupNode)
    }
    
    func dismissPopup() {
            // Remove the popup and background
            popupNode?.removeFromParent()
            self.childNode(withName: "popupBackground")?.removeFromParent()
        }
    
    func restartFood() {
        DataModel.shared.leftBalanceLocked = false
        DataModel.shared.rightBalanceLocked = false
        DataModel.shared.hasX = false
        for food in foodArrayLeft {
            food.node.removeFromParent()
        }
        for food in foodArrayRight {
            food.node.removeFromParent()
        }
        foodContLeft = 0
        foodContRight = 0
        foodArrayLeft.removeAll()
        foodArrayRight.removeAll()
        DataModel.shared.weightLeftSide = 0
        DataModel.shared.weightRightSide = 0
        
        
    }
    
    //Colocar a comida na tela
    func setupDragLabelFood(fruit: FruitEnum) -> FruitNode{
        
        // comida aparece na tela inicialmente no spawnLocation, por isso, booleanas são false
        isInTrayLeft = false
        isInTrayRight = false
        
        // para cada fruta, pega o peso, o nome da imagem e coloca no spawnLocation respectivo
        
        
        switch fruit {
        case .fruit1:
            let fruitNode = FruitEnum.fruit1.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = CGPoint(x:frame.size.width / 1.482, y: frame.size.height / 4.052)
            addChild(fruitNode.node)
            return fruitNode
        case .fruit2:
            let fruitNode = FruitEnum.fruit2.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = CGPoint(x:frame.size.width / 2, y: frame.size.height / 4.052)
            addChild(fruitNode.node)
            return fruitNode
        case .fruit3:
            let fruitNode = FruitEnum.fruit3.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = CGPoint(x:frame.size.width / 3.07, y: frame.size.height / 4.05)
            addChild(fruitNode.node)
            return fruitNode
        case .fruit5:
            let fruitNode = FruitEnum.fruit5.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.anchorPoint = CGPoint(x: 0.5, y: 0.3)
            fruitNode.node.position = CGPoint(x:frame.size.width / 6.61, y: frame.size.height / 4.052)
            addChild(fruitNode.node)
            return fruitNode
        case .unknown:
            let fruitNode = FruitEnum.unknown.toNode()
            fruitNode.node.name = "incognita"
            fruitNode.node.zPosition = 20
            fruitNode.node.anchorPoint = CGPoint(x: 0.5, y: 0.25)
            fruitNode.node.position = CGPoint(x:frame.size.width / 1.21, y: frame.size.height / 4.052)
            addChild(fruitNode.node)
            return fruitNode
        default:
            let fruitNode = FruitEnum.fruit1.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = CGPoint(x:frame.size.width / 1.482, y: frame.size.height / 4.052)
            addChild(fruitNode.node)
            return fruitNode
        }
    }
    
    // função que coloca o braço do polvo na tela
    func setupArm(){
        octopusArm.texture = SKTexture(imageNamed: "octopus-arm")
        octopusArm.size = CGSize(width: frame.size.width / 1.27, height: frame.size.height / 11.65)
        octopusArm.position = CGPoint(x: frame.size.width / 2.17, y: frame.size.height / 1.95)
        octopusArm.zPosition = 5
        
        octopusBody.texture = SKTexture(imageNamed: "octopus-body")
        octopusBody.size = CGSize(width: frame.size.width / 2.6, height: frame.size.height / 3.6)
        octopusBody.position = CGPoint(x: frame.size.width / 2.15, y: frame.size.height / 2.08 )
        octopusBody.zPosition = 7
        
        octopusFace.texture = SKTexture(imageNamed: "happy-face")
        octopusFace.size = CGSize(width: frame.size.width / 6.6, height: frame.size.height / 21.6)
        octopusFace.position = CGPoint(x: frame.size.width / 2.17, y: frame.size.height / 1.815)
        octopusFace.zPosition = 9
        
        addChild(octopusArm)
        
        addChild(octopusBody)
        
        addChild(octopusFace)
    }
    
    // função que coloca as bandejas na tela
    func setupTargets(){
        //        foodTrayLeft.color = SKColor.yellow
        
        foodTrayLeft.size = CGSize(width: frame.size.width / 2.96, height: frame.size.height / 31)
        foodTrayLeft.texture = SKTexture(imageNamed: "tray")
        foodTrayLeft.position.y = octopusArm.position.y + frame.size.height / 20.7
        foodTrayLeft.position.x = frame.size.width / 5.7
        foodTrayLeft.zPosition = 11
        
        foodInvisibleFrameLeft.size = CGSize(width: frame.size.width / 2.96, height: frame.size.height / 7.76)
        //foodInvisibleFrameLeft.color = .yellow
        foodInvisibleFrameLeft.position.y = octopusArm.position.y + frame.size.height / 10.3
        foodInvisibleFrameLeft.position.x = frame.size.width / 5.37
        foodInvisibleFrameLeft.zPosition = 1
        
        
        foodTrayRight.size = CGSize(width: frame.size.width / 2.96, height: frame.size.height / 31)
        foodTrayRight.texture = SKTexture(imageNamed: "tray")
        foodTrayRight.position = CGPoint(x: frame.size.width / 1.21, y: frame.size.height / 4.66)
        foodTrayRight.position.y = octopusArm.position.y + frame.size.height / 20.7
        foodTrayRight.zPosition = 11
        
        foodInvisibleFrameRight.size = CGSize(width: frame.size.width / 2.96, height: frame.size.height / 7.76)
        //foodInvisibleFrameRight.color = .yellow
        foodInvisibleFrameRight.position.y = octopusArm.position.y + frame.size.height / 10.3
        foodInvisibleFrameRight.position.x = frame.size.width / 1.26
        foodInvisibleFrameRight.zPosition = 1
        
        addChild(foodInvisibleFrameRight)
        addChild(foodTrayLeft)
        addChild(foodInvisibleFrameLeft)
        addChild(foodTrayRight)
    }
    
    // função que coloca os spawners na tela
    func setupSpawners(){
        
        shelf.texture = SKTexture(imageNamed: "shelf1")
        shelf.size = CGSize(width: frame.size.width / 0.811, height: frame.size.height / 2.026)
        shelf.position = CGPoint(x: frame.size.width / 2, y: 0)
        shelf.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        shelf.zPosition = 1
        
        addChild(shelf)
        
        spawner1.size = CGSize(width: 55, height: 120)
        spawner1.position = CGPoint(x:frame.size.width / 1.482, y: frame.size.height / 4.052)
        spawner1.zPosition = 10
        
        spawner2.size = CGSize(width: 55, height: 120)
        spawner2.position = CGPoint(x:frame.size.width / 2, y: frame.size.height / 4.052)
        spawner2.zPosition = 10
        
        spawner3.size = CGSize(width: 55, height: 120)
        spawner3.position = CGPoint(x:frame.size.width / 3.07, y: frame.size.height / 4.05)
        spawner3.zPosition = 10
        
        spawner5.size = CGSize(width: 55, height: 120)
        spawner5.position = CGPoint(x:frame.size.width / 6.61, y: frame.size.height / 4.052)
        spawner5.zPosition = 10
        
        spawnerIncognita.size = CGSize(width: 55, height: 120)
        spawnerIncognita.position = CGPoint(x:frame.size.width / 1.21, y: frame.size.height / 4.052)
        spawnerIncognita.zPosition = 10
        
        addChild(spawner1)
        addChild(spawner2)
        addChild(spawner3)
        addChild(spawner5)
        addChild(spawnerIncognita)
    }
    
    func setupTextLabelNumbers(fruit: FruitEnum) -> SKSpriteNode {
        switch fruit {
        case .fruit1:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "number1"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.position = CGPoint(x:frame.size.width / 1.482, y: frame.size.height / 4.052)
            addChild(fruitNode)
            return fruitNode
        case .fruit2:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "number2"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.position = CGPoint(x:frame.size.width / 2, y: frame.size.height / 4.052)
            addChild(fruitNode)
            return fruitNode
        case .fruit3:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "number3"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.position = CGPoint(x:frame.size.width / 3.07, y: frame.size.height / 4.05)
            addChild(fruitNode)
            return fruitNode
        case .fruit5:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "number5"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.anchorPoint = CGPoint(x: 0.5, y: 0.3)
            fruitNode.position = CGPoint(x:frame.size.width / 6.61, y: frame.size.height / 4.052)
            addChild(fruitNode)
            return fruitNode
        case .unknown:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "incognita"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.anchorPoint = CGPoint(x: 0.5, y: 0.25)
            fruitNode.position = CGPoint(x:frame.size.width / 1.21, y: frame.size.height / 4.052)
            addChild(fruitNode)
            return fruitNode
        default:
            let fruitNode = SKSpriteNode(texture: SKTexture(imageNamed: "number1"))
            fruitNode.name = "food"
            fruitNode.zPosition = 20
            fruitNode.anchorPoint = CGPoint(x: 0.5, y: 0.3)
            fruitNode.position = CGPoint(x:frame.size.width / 1.482, y: frame.size.height / 4.052)
            addChild(fruitNode)
            return fruitNode
        }
    }
    
    // função que move as bandejas de acordo com a posição do braço do polvo
    func rotate(angleRotation: CGFloat){
        
        let rotateAction = SKAction.rotate(toAngle: angle, duration: 1, shortestUnitArc: true)
        octopusArm.run(rotateAction)
        
        if DataModel.shared.weightLeftSide < DataModel.shared.weightRightSide{
            
            let moveActionLeftTray = SKAction.moveTo(y: trayPositionUpY + 40, duration: 1)
            self.foodInvisibleFrameLeft.run(moveActionLeftTray)
            
            let moveActionLeftPlate = SKAction.moveTo(y: trayPositionUpY, duration: 1)
            self.foodTrayLeft.run(moveActionLeftPlate)
            
            let moveActionRightTray = SKAction.moveTo(y: trayPositionDownY + 40, duration: 1)
            self.foodInvisibleFrameRight.run(moveActionRightTray)
            
            let moveActionRightPlate = SKAction.moveTo(y: trayPositionDownY, duration: 1)
            self.foodTrayRight.run(moveActionRightPlate)
            
        } else if DataModel.shared.weightLeftSide == DataModel.shared.weightRightSide {
            let moveActionLeftTray = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2  + 40, duration: 1)
            self.foodInvisibleFrameLeft.run(moveActionLeftTray)
            
            let moveActionLeftPlate = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2, duration: 1)
            self.foodTrayLeft.run(moveActionLeftPlate)
            
            let moveActionRightTray = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2  + 40, duration: 1)
            self.foodInvisibleFrameRight.run(moveActionRightTray)
            
            let moveActionRightPlate = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2, duration: 1)
            self.foodTrayRight.run(moveActionRightPlate)
            
        } else {
            let moveActionLeftTray = SKAction.moveTo(y: trayPositionDownY + 40, duration: 1)
            self.foodInvisibleFrameLeft.run(moveActionLeftTray)
            
            let moveActionLeftPlate = SKAction.moveTo(y: trayPositionDownY, duration: 1)
            self.foodTrayLeft.run(moveActionLeftPlate)
            
            let moveActionRightTray = SKAction.moveTo(y: trayPositionUpY + 40, duration: 1)
            self.foodInvisibleFrameRight.run(moveActionRightTray)
            
            let moveActionRightPlate = SKAction.moveTo(y: trayPositionUpY, duration: 1)
            self.foodTrayRight.run(moveActionRightPlate)
        }
    }
    
    //função que retorna a fruta para o local de spawn
    func returnToSpawn(){
        switch food.fruit {
        case .fruit1:
            removeChildren(in: [food.node])
        case .fruit2:
            removeChildren(in: [food.node])
        case .fruit3:
            removeChildren(in: [food.node])
        case .fruit5:
            removeChildren(in: [food.node])
        case .unknown:
            removeChildren(in: [food.node])
        default:
            removeChildren(in: [food.node])
        }
        
    }
    
    // função que é chamada a cada framde do jogo e atualiza a cena
    override func update(_ currentTime: TimeInterval) {
        
        if DataModel.shared.isSoundActivated {
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
        
        calculateAngle()
        scoreLabel.text = "\(DataModel.shared.equationCount) pts"
        
        if operationButton.changeOperation.selectedOperation == .subtraction {
            irButton.clickAction = reduceFood
        }
        else{
            irButton.clickAction = divideFood
        }
        
        // Se a comida entrar na bandeja, a posição da comida vai ser atualizada, as comidas são posicionadas lado a lado quando adicionadas mais de uma
        if isInTrayLeft {
            food.node.position.x = (foodTrayLeft.position.x - 80) + foodContLeft
            rotate(angleRotation: angle)
            
        } else if isInTrayRight {
            food.node.position.x = (foodTrayRight.position.x - 80) + foodContRight
            rotate(angleRotation: angle)
        }
        
        // atualiza a posição da comida de acordo com a posição da bandeja
        for food in foodArrayLeft {
            food.node.position.y = foodTrayLeft.position.y + 20
        }
        for food in foodArrayRight {
            food.node.position.y = foodTrayRight.position.y + 20
        }
        
    }
    
    // quando ocorre o toque, spawna uma fruta e coloca ela na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode.name == "soundButton" {
                DataModel.shared.soundIsOn()
            }
            
            // Handle button tap
            if touchedNode.name == "button" {
                showPopup()
            }
            
            // Handle popup close button tap
            if touchedNode.name == "closePopup" {
                dismissPopup()
            }
            
            // Optionally: Handle tap outside the popup to dismiss it
            if touchedNode.name == "popupBackground" {
                dismissPopup()
            }
            
            if touchedNode.name == "menuButton" {
                if DataModel.shared.isSoundActivated {
                    DataModel.shared.audioPlayer?.stop()
                }
                backMenu()
            }
            
            
            if isCorrect == false{
                //let position = touch.location(in: self)
                if spawner1.frame.contains(touch.previousLocation(in: self)){
                    food = setupDragLabelFood(fruit: .fruit1)
                }
                else if spawner2.frame.contains(touch.previousLocation(in: self)){
                    food = setupDragLabelFood(fruit: .fruit2)
                    
                }
                else if spawner3.frame.contains(touch.previousLocation(in: self)) {
                    food = setupDragLabelFood(fruit: .fruit3)
                }
                else if spawner5.frame.contains(touch.previousLocation(in: self)) {
                    food = setupDragLabelFood(fruit: .fruit5)
                }
                else if spawnerIncognita.frame.contains(touch.previousLocation(in: self)) {
                    food = setupDragLabelFood(fruit: .unknown)
                }
            }
            
        }
    }
    
    func backMenu() {
        let newScene = MenuScene()
        self.changeTo(scene: newScene)
    }
    
    // quando arrasta uma fruta, ela segue o arrasto
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        
        if food.node.frame.contains(touch.previousLocation(in: self)) {
            food.node.position = touch.location(in: self)
        }
    }
    
    // quando solta uma fruta, e esta estiver dentro de uma bandeja, ela é adicionada no foodArray e, caso seja a bandeja da esquerda, é preciso ter um X adicionado
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if foodInvisibleFrameLeft.frame.contains(food.node.position) && food.fruit.value + DataModel.shared.weightLeftSide <= DataModel.shared.weight { // condição que adiciona uma fruta na bandeja da esquerda desde que a fruta não seja maior que o valor máximo de cada lado da equação
            
            
            
            if food.node.name == "food" || food.node.name == "incognita" {
                balanca.addLeftFruit(fruit: food.fruit)
                if !(DataModel.shared.leftBalanceLocked){ // se a bandeja não estiver travada, adiciona fruta
                    if food.node.name == "incognita"{ // condição que verifica que tem incógnita na bandeja da esquerda
                        DataModel.shared.hasX = true
                        food.node.name = "incognitaAdded"
                        food.node.anchorPoint = CGPoint(x: 0.5, y: 0.2)
                    }
                    else if food.fruit.value == 5 {
                        food.node.name = "foodAdded"
                        food.node.anchorPoint = CGPoint(x: 0.5, y: 0.2)
                    }
                    else{
                        food.node.name = "foodAdded"
                    }
                    isInTrayLeft = true
                    foodArrayLeft.append(food)
                    foodContLeft += frame.size.width / 13.03
                }
                
                if DataModel.shared.weightLeftSide == DataModel.shared.weight{
                    print("travou esquerdaa")
                    balanca.addLeftFruit(fruit: food.fruit)
                }
                
            }
        } else if foodInvisibleFrameRight.frame.contains(food.node.position) && food.fruit.value + DataModel.shared.weightRightSide <= DataModel.shared.weight{ // condição que adiciona uma fruta na bandeja da direita desde que a fruta não seja maior que o valor máximo de cada lado da equação
            
            if food.node.name == "food"{
                balanca.addRightFruit(fruit: food.fruit)
                if !(DataModel.shared.rightBalanceLocked){ // se a bandeja não estiver travada, adiciona fruta
                    food.node.name = "foodAdded"
                    isInTrayRight = true
                    foodArrayRight.append(food)
                    foodContRight += frame.size.width / 13.03
                }
                
                if DataModel.shared.weightRightSide == DataModel.shared.weight{
                    print("travou direita")
                    balanca.addRightFruit(fruit: food.fruit)
                }
            }
            else {
                if !(isInTrayLeft && isInTrayRight){
                    if (food.node.name == "incognita") {
                        food.node.position = CGPoint(x:frame.size.width / 1.21, y: frame.size.height / 4.052)
                        foodRemovedArray.append(food.node)
                    }
                    else if (food.node.name == "food"){
                        returnToSpawn()
                    }
                }
                
                else if (food.node.name == "food") || (food.node.name == "incognita"){
                    returnToSpawn()
                }
            }
        }
        else {
            if !(isInTrayLeft && isInTrayRight){
                if (food.node.name == "incognita") {
                    food.node.position = CGPoint(x:frame.size.width / 1.21, y: frame.size.height / 4.052)
                    foodRemovedArray.append(food.node)
                }
                else if (food.node.name == "food"){
                    returnToSpawn()
                }
            }
            
            else if (food.node.name == "food") || (food.node.name == "incognita"){
                returnToSpawn()
            }
            
        }
    }
}
