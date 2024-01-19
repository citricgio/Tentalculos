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
    
    let spawner1 = SKSpriteNode()
    let spawner2 = SKSpriteNode()
    
    var bin1Position = CGPoint(x: 80, y: 200)
    var bin2Position = CGPoint(x: 340, y: 200)
    
    var isInBin1: Bool = false
    var isInBin2: Bool = false
    
    var spawnLocation = CGPoint(x:200, y: 30)
    
    override func didMove(to view: SKView) {
        
        //setupDragLabelFood()
        setupSpawners()
        setupTargets()
        backgroundColor = .white
        
    }
    //Colocar o texto na tela
    func setupDragLabelFood() {
        isInBin1 = false
        isInBin2 = false
        
        switch food {
        case .fruta1:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.zPosition = 20
            foodNode.position = CGPoint(x: 80, y: 100)
            addChild(foodNode)
        case .fruta2:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.zPosition = 20
            foodNode.position = CGPoint(x: 340, y: 100)
            addChild(foodNode)
        case .fruta3:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.zPosition = 20
            addChild(foodNode)
        case .fruta5:
            foodNode = SKSpriteNode(imageNamed: food.nome)
            foodNode.zPosition = 20
            addChild(foodNode)
//        default:
//            var foodNode1 = SKSpriteNode(imageNamed: food.nome)
//            foodNode1.zPosition = 20
//            addChild(foodNode1)
        }
        
    }
    func setupTargets(){
        foodBin.color = SKColor.yellow
        foodBin.size = CGSize(width: 200, height: 200)
        foodBin.position = CGPoint(x: 80, y: 500)
        foodBin.zPosition = 10
        foodBin2.color = SKColor.yellow
        foodBin2.size = CGSize(width: 200, height: 200)
        foodBin2.position = CGPoint(x: 340, y: 500)
        foodBin2.zPosition = 10
        
        addChild(foodBin)
        addChild(foodBin2)
    }
    
    func setupSpawners(){
        spawner1.color = SKColor.red
        spawner1.size = CGSize(width: 200, height: 200)
        spawner1.position = CGPoint(x: 80, y: 100)
        spawner1.zPosition = 10
        
        spawner2.color = SKColor.red
        spawner2.size = CGSize(width: 200, height: 200)
        spawner2.position = CGPoint(x: 340, y: 100)
        spawner2.zPosition = 10
        
        addChild(spawner1)
        addChild(spawner2)
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
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Se a comida entrar na primeira bin, a posicao vai ser atualizada junto com a bandeja, e se a comida entrar a bandeja cria uma acao para ir para um lugar especifico
        if isInBin1 {
            
            foodNode.position = foodBin.position
            let moveAction = SKAction.moveTo(y: 340, duration: 3)
            foodBin.run(moveAction)
            
        } else if isInBin2 {
            
            foodNode.position = foodBin2.position
            let moveAction = SKAction.moveTo(y: 340, duration: 3)
            foodBin2.run(moveAction)
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        
        
        if foodNode.frame.contains(touch.previousLocation(in: self)){
            
            foodNode.position = touch.location(in: self)
            isInBin1 = false
            isInBin2 = false
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if foodNode.name == "yellow"{
            
            if foodBin.frame.contains(foodNode.position){
                
                isInBin1 = true
                foodNode.position = bin1Position
                
            } else if foodBin2.frame.contains(foodNode.position) {
                
                foodNode.position = bin2Position
                isInBin2 = true
                
            } else {
                
                foodNode.position = spawnLocation
            }
        }
    }
}
