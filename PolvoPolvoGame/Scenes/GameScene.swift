// GameScene.swift
// BluebinProject
//
// Created by Giovanna Micher on 19/01/24.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var food: FrutaEnum = .fruta1
    var foodNode = SKSpriteNode()
    let foodTexture = SKTexture(imageNamed: "bushes")
    
    let foodBin = SKSpriteNode()
    let foodBin2 = SKSpriteNode()
    
    let armSquare = SKSpriteNode()
    
    let spawner1 = SKSpriteNode()
    let spawner2 = SKSpriteNode()
    let spawner3 = SKSpriteNode()
    
    var bin1Position = CGPoint(x: 80, y: 200)
    var bin2Position = CGPoint(x: 340, y: 200)
    
    var armSquarePosition = CGPoint(x: 200 , y: 400)
    
    var isInBin1: Bool = false
    var isInBin2: Bool = false
    
    var gerador: GeradorPesos = GeradorPesos()
    var balanca: BalancaDados = BalancaDados()
    
    var angle: CGFloat = 0
    
    var binPositionUpY: CGFloat = 500
    var binPositionDownY: CGFloat = 300
    
    var spawnLocation1 = CGPoint(x:80, y: 100)
    var spawnLocation2 = CGPoint(x:340, y: 100)
    var spawnLocation3 = CGPoint(x:200, y: 100)
    
    var foodArrayLeft: [SKSpriteNode] = []
    var foodArrayRight: [SKSpriteNode] = []
    
    var foodContLeft: CGFloat = 0
    var foodContRight: CGFloat = 0
    
    var hasX: Bool = false
    
    override func didMove(to view: SKView) {
        
        //setupDragLabelFood()
        setupGame()
        setupSpawners()
        setupArm()
        setupTargets()
        backgroundColor = .white
        
    }
    
    func setupGame(){
        gerador.Gerar_Numeros_Basico()
    }
    
    func calculateAngle() {
        if DataModel.shared.peso_lado_esquerdo < DataModel.shared.peso_lado_direito{
            angle = -(.pi / 4)
            
        } else if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso_lado_direito {
            angle = 0
            
        } else {
            angle = .pi / 4
        }
        
    }
    
    
    //Colocar a comida na tela
    func setupDragLabelFood() {
        isInBin1 = false
        isInBin2 = false
        
        switch food {
        case .fruta1:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation1
            addChild(foodNode)
        case .fruta2:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation2
            addChild(foodNode)
        case .fruta3:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "food"
            foodNode.zPosition = 20
            addChild(foodNode)
        case .fruta5:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.zPosition = 20
            addChild(foodNode)
        case .incognita:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.name = "incognita"
            foodNode.zPosition = 20
            foodNode.position = spawnLocation3
            addChild(foodNode)
        }
        
    }
    
    func setupArm(){
        armSquare.color = SKColor.black
        armSquare.size = CGSize(width: 400, height: 200)
        armSquare.position = CGPoint(x: 200 , y: 400)
        armSquare.zPosition = 5
        
        addChild(armSquare)
    }
    
    func setupTargets(){
        foodBin.color = SKColor.yellow
        foodBin.size = CGSize(width: 200, height: 200)
        foodBin.position.y = armSquare.position.y + 100
        foodBin.position.x = 80
        foodBin.zPosition = 10
        foodBin2.color = SKColor.yellow
        foodBin2.size = CGSize(width: 200, height: 200)
        foodBin2.position = bin2Position
        foodBin2.position.y = armSquare.position.y + 100

        foodBin2.zPosition = 10
        
        addChild(foodBin)
        addChild(foodBin2)
    }
    
    func setupSpawners(){
        spawner1.color = SKColor.red
        spawner1.size = CGSize(width: 200, height: 200)
        spawner1.position = spawnLocation1
        spawner1.zPosition = 10
        
        spawner2.color = SKColor.blue
        spawner2.size = CGSize(width: 200, height: 200)
        spawner2.position = spawnLocation2
        spawner2.zPosition = 10
        
        spawner3.color = SKColor.green
        spawner3.size = CGSize(width: 200, height: 200)
        spawner3.position = spawnLocation3
        spawner3.zPosition = 10
                
        addChild(spawner1)
        addChild(spawner2)
        addChild(spawner3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if spawner1.frame.contains(touch.previousLocation(in: self)){
                food = .fruta1
                setupDragLabelFood()
            }
            else if spawner2.frame.contains(touch.previousLocation(in: self)){
                food = .fruta2
                setupDragLabelFood()
            }
            else if spawner3.frame.contains(touch.previousLocation(in: self)) {
                food = .incognita
                setupDragLabelFood()
            }
        }
    }
    
    func rotate(angleRotation: CGFloat){
        let rotateAction = SKAction.rotate(toAngle: angle, duration: 1, shortestUnitArc: true)
        //let rotateAction = SKAction.rotate(byAngle: angleRotation, duration: 1)

        armSquare.run(rotateAction)
        
        if DataModel.shared.peso_lado_esquerdo < DataModel.shared.peso_lado_direito{
            
            let moveAction = SKAction.moveTo(y: binPositionUpY, duration: 1)
            self.foodBin.run(moveAction)
            let moveAction2 = SKAction.moveTo(y: binPositionDownY, duration: 1)
            self.foodBin2.run(moveAction2)
            
        } else if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso_lado_direito {
            let moveAction = SKAction.moveTo(y: (binPositionUpY + binPositionDownY) / 2, duration: 1)
            self.foodBin.run(moveAction)
//            foodBin.run(moveAction)
            let moveAction2 = SKAction.moveTo(y: (binPositionUpY + binPositionDownY) / 2, duration: 1)
            self.foodBin2.run(moveAction2)
            
        } else {
            let moveAction = SKAction.moveTo(y: binPositionDownY, duration: 1)
            self.foodBin.run(moveAction)
            let moveAction2 = SKAction.moveTo(y: binPositionUpY, duration: 1)
            self.foodBin2.run(moveAction2)
        }
    }
    
    func returnToSpawn(){
        switch food {
        case .fruta1:
            foodNode.position = spawnLocation1
        case .fruta2:
            foodNode.position = spawnLocation2
        case .incognita:
            foodNode.position = spawnLocation3
        default:
            foodNode.position = spawnLocation1
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        calculateAngle()
        // Se a comida entrar na primeira bin, a posicao vai ser atualizada junto com a bandeja, e se a comida entrar a bandeja cria uma acao para ir para um lugar especifico
        if isInBin1 {
            foodNode.position.x = (foodBin.position.x - 50) + foodContLeft
            rotate(angleRotation: angle)
            
        } else if isInBin2 {
            foodNode.position.x = (foodBin2.position.x - 50) + foodContRight
            rotate(angleRotation: angle)
        }
        
        for food in foodArrayLeft {
            food.position.y = foodBin.position.y
        }
        for food in foodArrayRight {
            food.position.y = foodBin2.position.y
        }
        
        if DataModel.shared.balanca_direita_travada && DataModel.shared.balanca_esquerda_travada {
            //funcao spawnar botao de proximo
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if foodNode.frame.contains(touch.previousLocation(in: self)) {
            
            foodNode.position = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if foodBin.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_esquerdo <= DataModel.shared.peso {
                balanca.adicionar_fruta_esquerda(fruta: food)
                
                if !(DataModel.shared.balanca_esquerda_travada){
                    if foodNode.name == "incognita"{
                        hasX = true
                    }
                    isInBin1 = true
                    foodArrayLeft.append(foodNode)
                    foodContLeft += 10
                } else {
                    returnToSpawn()
                }
                
            } else if foodBin2.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_direito <= DataModel.shared.peso{
                if foodNode.name == "food"{
                    balanca.adicionar_fruta_direita(fruta: food)
                    if !(DataModel.shared.balanca_direita_travada){
                        isInBin2 = true
                        foodArrayRight.append(foodNode)
                        foodContRight += 10
                    } else {
                        returnToSpawn()
                    }
                } else {
                    returnToSpawn()
                }
            }
        else {
            returnToSpawn()
        }
    }
    
}
