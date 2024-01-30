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
    var food: FrutaEnum = .fruta1
    
    // instância de GeradorPesos para gerar uma equacão aleatória
    var gerador: GeradorPesos = GeradorPesos()
    
    // instância de BalancaDados para adicionar e travar os itens na balança
    var balanca: BalancaDados = BalancaDados()
    
    // instância de comida
    var foodNode = SKSpriteNode()
    
    // arrays que armazenam a quantidade de comida em cada bandeja
    var foodArrayLeft: [SKSpriteNode] = []
    var foodArrayRight: [SKSpriteNode] = []
    
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
    var spawnLocationIncognita = CGPoint(x:220, y: 100)
    var spawnLocation1 = CGPoint(x:180, y: 100)
    var spawnLocation2 = CGPoint(x:140, y: 100)
    var spawnLocation3 = CGPoint(x:100, y: 100)
    var spawnLocation5 = CGPoint(x:60, y: 100)
    
    var foodRemovedArray: [SKSpriteNode] = []
    
    // variável que indica o ângulo dos braços do polvo
    var angle: CGFloat = 0
    
    var isCorrect: Bool = false
    
    var nextButton: NextButton = NextButton(action: {}, textLabel: "lalaal")
    
    var operationButton: SpriteButtonOperation = SpriteButtonOperation(action: {})
    
    var isButtonAdded: Bool = false
    
    var background = SKSpriteNode(imageNamed: "background")
    
    var changeOperation = OperationButton()
                
    // função que carrega as coisas na tela (quando a cena do sprite kit é movida para a tela)
    override func didMove(to view: SKView) {
        
        food = .fruta1
        let food1 = setupDragLabelFood()
        foodRemovedArray.append(food1)
        
        food = .fruta2
        let food2 = setupDragLabelFood()
        foodRemovedArray.append(food2)
        
        food = .fruta3
        let food3 = setupDragLabelFood()
        foodRemovedArray.append(food3)
        
        food = .fruta5
        let food5 = setupDragLabelFood()
        foodRemovedArray.append(food5)
        
        food = .incognita
        let incognita = setupDragLabelFood()
        foodRemovedArray.append(incognita)
        
        setupGame()
        setupSpawners()
        setupArm()
        setupTargets()
        
        nextButton = NextButton(action: isCorrect ? finalizeCheck : firstCheck, textLabel: isCorrect ? "Finalizar" : "Próximo")
        addChild(nextButton)
        background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        addChild(background)
        
    }
    
    func addOperationButtons() {
        let operationNumbersButton = SpriteButtonNumbers(){
            print("ola")
        }
        
//        operationNumbersButton.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 3)
//        operationNumbersButton.zPosition = 20
//        
//        operationButton.position = CGPoint(x: frame.size.width / 4 , y: frame.size.height / 3)
//        operationButton.zPosition = 20
        
        addChild(operationNumbersButton)
//        addChild(operationButton)
    }
    
    func firstCheck() {
        if DataModel.shared.balanca_direita_travada && DataModel.shared.balanca_esquerda_travada && DataModel.shared.hasX {
            //desespawnar e mostra botao de operacoes
            print("ACERTOUUU")
            isCorrect = true
            nextButton.text.text = "Finalizar"
            removeChildren(in: [spawner1, spawner2, spawner3, spawner5, spawnerIncognita])
            removeChildren(in: foodRemovedArray)
            addOperationButtons()
            
        } else {
            print("errouuuuu")
        }
        
    }
    
    func finalizeCheck(){
        
    }
    
    // função que faz as bases iniciais do jogo
    func setupGame(){
        gerador.Gerar_Numeros_Basico() // gera uma equação aleatória
    }
    
    // função que calcula o ângulo de rotação do braço do polvo (vai de -45º até 45º)
    func calculateAngle() {
        if DataModel.shared.peso_lado_esquerdo < DataModel.shared.peso_lado_direito{
            angle = -(.pi / 6)
            
        } else if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso_lado_direito {
            angle = 0
            
        } else {
            angle = .pi / 6
        }
    }
    
    
    //Colocar a comida na tela
    func setupDragLabelFood() -> SKSpriteNode {
        
        // comida aparece na tela inicialmente no spawnLocation, por isso, booleanas são false
        isInTrayLeft = false
        isInTrayRight = false
        
        // para cada fruta, pega o peso, o nome da imagem e coloca no spawnLocation respectivo
        switch food {
        case .fruta1:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation1
            addChild(foodNode)
            return foodNode
        case .fruta2:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation2
            addChild(foodNode)
            return foodNode
        case .fruta3:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation3
            addChild(foodNode)
            return foodNode
        case .fruta5:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation5
            addChild(foodNode)
            return foodNode
        case .incognita:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "incognita"
            foodNode.zPosition = 20
            foodNode.position = spawnLocationIncognita
            addChild(foodNode)
            return foodNode
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
        
        if DataModel.shared.peso_lado_esquerdo < DataModel.shared.peso_lado_direito{
            
            let moveActionLeftTray = SKAction.moveTo(y: trayPositionUpY + 40, duration: 1)
            self.foodInvisibleFrameLeft.run(moveActionLeftTray)
            
            let moveActionLeftPlate = SKAction.moveTo(y: trayPositionUpY, duration: 1)
            self.foodTrayLeft.run(moveActionLeftPlate)
            
            let moveActionRightTray = SKAction.moveTo(y: trayPositionDownY + 40, duration: 1)
            self.foodInvisibleFrameRight.run(moveActionRightTray)
            
            let moveActionRightPlate = SKAction.moveTo(y: trayPositionDownY, duration: 1)
            self.foodTrayRight.run(moveActionRightPlate)
            
        } else if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso_lado_direito {
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
        switch food {
        case .fruta1:
            removeChildren(in: [foodNode])
        case .fruta2:
            removeChildren(in: [foodNode])
        case .fruta3:
            removeChildren(in: [foodNode])
        case .fruta5:
            removeChildren(in: [foodNode])
        case .incognita:
            removeChildren(in: [foodNode])
        }
        
    }
    
    // função que é chamada a cada framde do jogo e atualiza a cena
    override func update(_ currentTime: TimeInterval) {
        calculateAngle()
        
        // Se a comida entrar na bandeja, a posição da comida vai ser atualizada, as comidas são posicionadas lado a lado quando adicionadas mais de uma
        if isInTrayLeft {
            foodNode.position.x = (foodTrayLeft.position.x - 60) + foodContLeft
            rotate(angleRotation: angle)
            
        } else if isInTrayRight {
            foodNode.position.x = (foodTrayRight.position.x - 60) + foodContRight
            rotate(angleRotation: angle)
        }
        
        // atualiza a posição da comida de acordo com a posição da bandeja
        for food in foodArrayLeft {
            food.position.y = foodTrayLeft.position.y + 20
        }
        for food in foodArrayRight {
            food.position.y = foodTrayRight.position.y + 20
        }
        
    }
    
    // quando ocorre o toque, spawna uma fruta e coloca ela na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            //let position = touch.location(in: self)
            if spawner1.frame.contains(touch.previousLocation(in: self)){
                food = .fruta1
                setupDragLabelFood()
            }
            else if spawner2.frame.contains(touch.previousLocation(in: self)){
                food = .fruta2
                setupDragLabelFood()
            }
            else if spawner3.frame.contains(touch.previousLocation(in: self)) {
                food = .fruta3
                setupDragLabelFood()
            }
            else if spawner5.frame.contains(touch.previousLocation(in: self)) {
                food = .fruta5
                setupDragLabelFood()
            }
            else if spawnerIncognita.frame.contains(touch.previousLocation(in: self)) {
                food = .incognita
                setupDragLabelFood()
            }
        }
    }
    
    // quando arrasta uma fruta, ela segue o arrasto
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if foodNode.frame.contains(touch.previousLocation(in: self)) {
            foodNode.position = touch.location(in: self)
        }
    }
    
    // quando solta uma fruta, e esta estiver dentro de uma bandeja, ela é adicionada no foodArray e, caso seja a bandeja da esquerda, é preciso ter um X adicionado
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if foodInvisibleFrameLeft.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_esquerdo <= DataModel.shared.peso { // condição que adiciona uma fruta na bandeja da esquerda desde que a fruta não seja maior que o valor máximo de cada lado da equação
            

            
            if foodNode.name == "food" || foodNode.name == "incognita" {
                balanca.adicionar_fruta_esquerda(fruta: food)
                if !(DataModel.shared.balanca_esquerda_travada){ // se a bandeja não estiver travada, adiciona fruta
                    if foodNode.name == "incognita"{ // condição que verifica que tem incógnita na bandeja da esquerda
                        DataModel.shared.hasX = true
                    }
                    foodNode.name = "foodAdded"
                    isInTrayLeft = true
                    foodArrayLeft.append(foodNode)
                    foodContLeft += 15
                }
                
                if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso{
                    print("travou esquerdaa")
                    balanca.adicionar_fruta_esquerda(fruta: food)
                }
                
            }
        } else if foodInvisibleFrameRight.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_direito <= DataModel.shared.peso{ // condição que adiciona uma fruta na bandeja da direita desde que a fruta não seja maior que o valor máximo de cada lado da equação
            
            if foodNode.name == "food"{
                balanca.adicionar_fruta_direita(fruta: food)
                if !(DataModel.shared.balanca_direita_travada){ // se a bandeja não estiver travada, adiciona fruta
                    foodNode.name = "foodAdded"
                    isInTrayRight = true
                    foodArrayRight.append(foodNode)
                    foodContRight += 15
                }
                
                if DataModel.shared.peso_lado_direito == DataModel.shared.peso{
                    print("travou direita")
                    balanca.adicionar_fruta_direita(fruta: food)
                }
            } 
            else {
                if !(isInTrayLeft && isInTrayRight){
                    if (foodNode.name == "incognita") {
                        foodNode.position = spawnLocationIncognita
                        foodRemovedArray.append(foodNode)
                    }
                    else if (foodNode.name == "food"){
                        returnToSpawn()
                    }
                }
                
                else if (foodNode.name == "food") || (foodNode.name == "incognita"){
                    returnToSpawn()
                }
            }
        }
        else {
            if !(isInTrayLeft && isInTrayRight){
                if (foodNode.name == "incognita") {
                    foodNode.position = spawnLocationIncognita
                    foodRemovedArray.append(foodNode)
                }
                else if (foodNode.name == "food"){
                    returnToSpawn()
                }
            }
            
            else if (foodNode.name == "food") || (foodNode.name == "incognita"){
                returnToSpawn()
            }
            
        }
    }
    
}
