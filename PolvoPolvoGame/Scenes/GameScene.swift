// GameScene.swift
// BluebinProject
//
// Created by Giovanna Micher on 19/01/24.
//
import Foundation
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
    var trayPositionUpY: CGFloat = 535
    var trayPositionDownY: CGFloat = 395
    
    // variáveis que indicam se tem comida na bandeja ou não
    var isInTrayLeft: Bool = false
    var isInTrayRight: Bool = false
    
    // braço do polvo
    let octopusArm = SKSpriteNode()
    
    let octopusBody = SKSpriteNode()
    
    // spawners da onde saem as comidas
    let spawner1 = SKSpriteNode()
    let spawner2 = SKSpriteNode()
    let spawner3 = SKSpriteNode()
    let spawner5 = SKSpriteNode()
    let spawnerIncognita = SKSpriteNode()

    
    // localização dos spawners
    var spawnLocationIncognita = CGPoint(x:380, y: 260)
    var spawnLocation1 = CGPoint(x:300, y: 260)
    var spawnLocation2 = CGPoint(x:220, y: 260)
    var spawnLocation3 = CGPoint(x:140, y: 260)
    var spawnLocation5 = CGPoint(x:60, y: 260)
    
    var foodRemovedArray: [SKSpriteNode] = []
    
    // variável que indica o ângulo dos braços do polvo
    var angle: CGFloat = 0
    
    var isCorrect: Bool = false
    
    var nextButton: NextButton = NextButton(action: {}, textLabel: "Próximo")
    
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
    
    var isAlive: [Bool] = [true,true,true]
    var livesCount: Int = 0

    // função que carrega as coisas na tela (quando a cena do sprite kit é movida para a tela)
    override func didMove(to view: SKView) {
        
        let food1 = setupDragLabelFood(fruit: .fruit1)
        foodRemovedArray.append(food1.node)
        
        let food2 = setupDragLabelFood(fruit: .fruit2)
        foodRemovedArray.append(food2.node)
        
        let food3 = setupDragLabelFood(fruit: .fruit3)
        foodRemovedArray.append(food3.node)
        
        let food5 = setupDragLabelFood(fruit: .fruit5)
        foodRemovedArray.append(food5.node)
        
        let incognita = setupDragLabelFood(fruit: .unknown)
        foodRemovedArray.append(incognita.node)
        
        DataModel.shared.weightRightSide = 0
        DataModel.shared.weightLeftSide = 0
        
        setupGame()
        setupSpawners()
        setupArm()
        setupTargets()
        
        nextButton = NextButton(action: isCorrect ? finalizeCheck : firstCheck, textLabel: isCorrect ? "Finalizar" : "Próximo")
        addChild(nextButton)
        
        background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        addChild(background)
        
        addScore()
        addLives()
        
        playSound(sound: "Jogo", type: "mp3=")
        
    }
    
    func addOperationButtons() {
        operationNumbersButton = SpriteButtonNumbers(){
           //print("ola")
        }
        addChild(operationNumbersButton)
        
        irButton = SpriteButtonReduce(action: reduceFood, textLabel: "Ir")
        addChild(irButton)
    
        operationButton = SpriteButtonOperation() {
            //print("cliquei")
        }
        addChild(operationButton)
        
    }
    
    
    
    
    // adicionar a label dos pontos na tela
    func addScore() {
        scoreLabel.text = "Pontos: \(score)"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: size.width / 2, y: 700)
        
        
        addChild(scoreLabel)
    }
    
    // fazer o update dos pontos
    func updateScore() {
        DataModel.shared.equationCount += 1
        scoreLabel.text = "Pontos: \(DataModel.shared.equationCount)"
    }
    
    // adicionar as vidas na tela e adiciona-las numa array com todas as vidas
    func addLives() {
        live1 = SKSpriteNode(texture: plate)
        live1.position = CGPoint(x: 150, y: 650)
        live1.zPosition = 11
        live1.name = "live1"
        print("VIDA 1")
        
        addChild(live1)
        lives.append(live1)
        
        live2 = SKSpriteNode(texture: plate)
        live2.position = CGPoint(x: 200, y: 650)
        live2.zPosition = 11
        live2.name = "live2"
        print("VIDA 2")
        
        addChild(live2)
        lives.append(live2)

        
        live3 = SKSpriteNode(texture: plate)
        live3.position = CGPoint(x: 250, y: 650)
        live3.zPosition = 11
        live3.name = "live3"
        print("VIDA 3")
        
        addChild(live3)
        lives.append(live3)

    }
    
    // muda o estado do prato para quebrado
    func updateLives() {
        // passa pelo array de vidas
        for i in 0...lives.count - 1 {
            // se a posicao daquela vida se tornar falsa porque o jogador perdeu, pega a vida que está naquela posicao e troca a imagem para brokenPlate
            if isAlive[i] == false {
                let live = lives[i]
                live.texture = brokenPlate
//                playSound(sound: "Prato quebrando", type: "mp3")

            }
        }
    }
    
    func endGame() {
                //pega a primeira vida e confirma se a posicao dela é verdadeira
        if childNode(withName: "live1") != nil && isAlive[0] == true {
            // muda a sua posicao para falso, chama a funcao updateLives() e aumenta o contador que acompanha a quantidade de vidas que o jogador tem
            isAlive[0] = false
            print("errouuuuu1")
            updateLives()
            livesCount += 1
            print("oiiii \(livesCount)")
            playSound(sound: "Prato quebrando", type: "mp3")
            playSound(sound: "Jogo", type: "mp3")
        }
        else if childNode(withName: "live2") != nil && isAlive[1] == true {
            isAlive[1] = false
            print("errouuuuu2")
            updateLives()
            livesCount += 1
            print("oiiii \(livesCount)")
            playSound(sound: "Prato quebrando", type: "mp3")
            playSound(sound: "Jogo", type: "mp3")

        }
        else if childNode(withName: "live3") != nil && isAlive[2] == true {
            isAlive[2] = false
            print("errouuuuu3")
            updateLives()
            livesCount += 1
            print("oiiii \(livesCount)")
            playSound(sound: "Prato quebrando", type: "mp3")
            endGame()
        }
        
        // se o contador de vidas chegar a 3, muda para a tela final de perder o jogo
        if livesCount == 3 {
            let endGameScene = EndScene()
            self.changeTo(scene: endGameScene)
//            playSound(sound: "Derrota2", type: "mp3")
        }
    }
    
    
    func firstCheck() {
        if DataModel.shared.rightBalanceLocked && DataModel.shared.leftBalanceLocked && DataModel.shared.hasX {
            //desespawnar e mostra botao de operacoes
            print("ACERTOUUU")
            isCorrect = true
            nextButton.text.text = "Finalizar"
            removeChildren(in: [spawner1, spawner2, spawner3, spawner5, spawnerIncognita])
            removeChildren(in: foodRemovedArray)
            addOperationButtons()
            updateScore()
            
        } else {

            endGame()

            
        }
        
    }
    
    
    
    func finalizeCheck(){
        //vitoria ou derrota
        print("Vitoria")
    }
    
    // função que faz as bases iniciais do jogo
    func setupGame(){
        gerador.generateBasicEquation() // gera uma equação aleatória
    }
    
    // função que calcula o ângulo de rotação do braço do polvo (vai de -45º até 45º)
    func calculateAngle() {
        if DataModel.shared.weightLeftSide < DataModel.shared.weightRightSide{
            angle = -(.pi / 6)
            
        } else if DataModel.shared.weightLeftSide == DataModel.shared.weightRightSide {
            angle = 0
            
        } else {
            angle = .pi / 6
        }
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
            fruitNode.node.position = spawnLocation1
            addChild(fruitNode.node)
            return fruitNode
        case .fruit2:
            let fruitNode = FruitEnum.fruit2.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = spawnLocation2
            addChild(fruitNode.node)
            return fruitNode
        case .fruit3:
            let fruitNode = FruitEnum.fruit3.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = spawnLocation3
            addChild(fruitNode.node)
            return fruitNode
        case .fruit5:
            let fruitNode = FruitEnum.fruit5.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = spawnLocation5
            addChild(fruitNode.node)
            return fruitNode
        case .unknown:
            let fruitNode = FruitEnum.unknown.toNode()
            fruitNode.node.name = "incognita"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = spawnLocationIncognita
            addChild(fruitNode.node)
            return fruitNode
        default:
            let fruitNode = FruitEnum.fruit1.toNode()
            fruitNode.node.name = "food"
            fruitNode.node.zPosition = 20
            fruitNode.node.position = spawnLocation1
            addChild(fruitNode.node)
            return fruitNode
        }
    }
    
    // função que coloca o braço do polvo na tela
    func setupArm(){
        octopusArm.texture = SKTexture(imageNamed: "octopus-arm")
        octopusArm.size = CGSize(width: 338, height: 80)
        octopusArm.position = CGPoint(x: frame.size.width / 2.25, y: frame.size.height / 1.775)
        octopusArm.zPosition = 5
        
        octopusBody.texture = SKTexture(imageNamed: "octopus-body")
        octopusBody.size = CGSize(width: 160, height: 259)
        octopusBody.position = CGPoint(x: frame.size.width / 2.25, y: frame.size.height / 1.89 )
        octopusBody.zPosition = 7
        
        addChild(octopusArm)
        
        addChild(octopusBody)
    }
    
    // função que coloca as bandejas na tela
    func setupTargets(){
//        foodTrayLeft.color = SKColor.yellow
        
        foodTrayLeft.size = CGSize(width: 145, height: 30)
        foodTrayLeft.texture = SKTexture(imageNamed: "tray")
        foodTrayLeft.position.y = octopusArm.position.y + 50
        foodTrayLeft.position.x = 72
        foodTrayLeft.zPosition = 11
        
        foodInvisibleFrameLeft.size = CGSize(width: 145, height: 120)
        foodInvisibleFrameLeft.color = .yellow
        foodInvisibleFrameLeft.position.y = octopusArm.position.y + 90
        foodInvisibleFrameLeft.position.x = 80
        foodInvisibleFrameLeft.zPosition = 10


        foodTrayRight.size = CGSize(width: 145, height: 30)
        foodTrayRight.texture = SKTexture(imageNamed: "tray")
        foodTrayRight.position = CGPoint(x: 340, y: 200)
        foodTrayRight.position.y = octopusArm.position.y + 50
        foodTrayRight.zPosition = 11
        
        foodInvisibleFrameRight.size = CGSize(width: 145, height: 120)
        foodInvisibleFrameRight.color = .yellow
        foodInvisibleFrameRight.position.y = octopusArm.position.y + 90
        foodInvisibleFrameRight.position.x = 340
        foodInvisibleFrameRight.zPosition = 10
        
        addChild(foodInvisibleFrameRight)
        addChild(foodTrayLeft)
        addChild(foodInvisibleFrameLeft)
        addChild(foodTrayRight)
    }
    
    // função que coloca os spawners na tela
    func setupSpawners(){
        spawner1.color = SKColor.red
        spawner1.size = CGSize(width: 55, height: 120)
        spawner1.position = spawnLocation1
        spawner1.zPosition = 10
        
        spawner2.color = SKColor.blue
        spawner2.size = CGSize(width: 55, height: 120)
        spawner2.position = spawnLocation2
        spawner2.zPosition = 10
        
        spawner3.color = SKColor.green
        spawner3.size = CGSize(width: 55, height: 120)
        spawner3.position = spawnLocation3
        spawner3.zPosition = 10
        
        spawner5.color = SKColor.yellow
        spawner5.size = CGSize(width: 55, height: 120)
        spawner5.position = spawnLocation5
        spawner5.zPosition = 10
        
        spawnerIncognita.color = SKColor.orange
        spawnerIncognita.size = CGSize(width: 55, height: 120)
        spawnerIncognita.position = spawnLocationIncognita
        spawnerIncognita.zPosition = 10
        
        addChild(spawner1)
        addChild(spawner2)
        addChild(spawner3)
        addChild(spawner5)
        addChild(spawnerIncognita)
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
        calculateAngle()
        
        // Se a comida entrar na bandeja, a posição da comida vai ser atualizada, as comidas são posicionadas lado a lado quando adicionadas mais de uma
        if isInTrayLeft {
            food.node.position.x = (foodTrayLeft.position.x - 60) + foodContLeft
            rotate(angleRotation: angle)
            
        } else if isInTrayRight {
            food.node.position.x = (foodTrayRight.position.x - 60) + foodContRight
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
        if let touch = touches.first {
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
                    }
                    else{
                        food.node.name = "foodAdded"
                    }
                    isInTrayLeft = true
                    foodArrayLeft.append(food)
                    foodContLeft += 15
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
                    foodContRight += 15
                }
                
                if DataModel.shared.weightRightSide == DataModel.shared.weight{
                    print("travou direita")
                    balanca.addRightFruit(fruit: food.fruit)
                }
            } 
            else {
                if !(isInTrayLeft && isInTrayRight){
                    if (food.node.name == "incognita") {
                        food.node.position = spawnLocationIncognita
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
                    food.node.position = spawnLocationIncognita
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
