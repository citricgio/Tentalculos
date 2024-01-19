// GameScene.swift
// BluebinProject
//
// Created by Giovanna Micher on 19/01/24.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    
  let food = SKLabelNode()
    
  let foodBin = SKSpriteNode()
  let foodBin2 = SKSpriteNode()
    
  var bin1Position = CGPoint(x: 80, y: 200)
  var bin2Position = CGPoint(x: 340, y: 200)
    
  var isInBin1: Bool = false
  var isInBin2: Bool = false
    
  var spawnLocation = CGPoint(x:200, y: 30)
    
  override func didMove(to view: SKView) {
      
    setupDragLabelFood()
    setupTargets()
    backgroundColor = .white
      
  }
  //Colocar o texto na tela
  func setupDragLabelFood() {
    isInBin1 = false
    isInBin2 = false
    food.fontName = "Chalkduster"
    food.fontColor = .black
    food.fontSize = 20
    food.position = spawnLocation
    food.name = "yellow"
    food.text = "yellow"
    food.zPosition = 20
      
    addChild(food)
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
  override func update(_ currentTime: TimeInterval) {
    // Se a comida entrar na primeira bin, a posicao vai ser atualizada junto com a bandeja, e se a comida entrar a bandeja cria uma acao para ir para um lugar especifico
    if isInBin1 {
        
      food.position = foodBin.position
      let moveAction = SKAction.moveTo(y: 340, duration: 3)
      foodBin.run(moveAction)
        
    } else if isInBin2 {
        
      food.position = foodBin2.position
      let moveAction = SKAction.moveTo(y: 340, duration: 3)
      foodBin2.run(moveAction)
        
    }
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first!
      
    if food.frame.contains(touch.previousLocation(in: self)){
        
      food.position = touch.location(in: self)
      isInBin1 = false
      isInBin2 = false
    }
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if food.name == "yellow"{
        
      if foodBin.frame.contains(food.position){
          
        isInBin1 = true
        food.position = bin1Position
          
      } else if foodBin2.frame.contains(food.position) {
          
        food.position = bin2Position
        isInBin2 = true
          
      } else {
          
        food.position = spawnLocation
      }
    }
  }
}
