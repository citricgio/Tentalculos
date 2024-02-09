//
//  ReduceFood.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 06/02/24.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func reduceFood() {
        var soma_left = 0
        var aux_left = 0
        var cont_left = 0
        var deleteItemsArrayLeft : [SKSpriteNode] = []
        
        var soma_right = 0
        var aux_right = 0
        var cont_right = 0
        var deleteItemsArrayRight : [SKSpriteNode] = []
        // Se o botao da operacao for subtracao
        //if operationButton.changeOperation.selectedOperation == .subtracao {
        
        // valor subtraído for maior que o peso da balanca, nao faz nada
        if operationNumbersButton.changeNumber.selectedFruit.value > DataModel.shared.weight - DataModel.shared.valueX {
            print("Numero maior que o peso, acao negada")
            endGame()
        }
        // valor subtraído for igual ao peso da balanca, nao faz nada
        else if operationNumbersButton.changeNumber.selectedFruit.value == DataModel.shared.weight {
            print("Numero igual ao peso, acao negada")
            endGame()
            
            //valor subtraído é menor que o peso da balanca
        } else {
            calculator.operationSubtraction(value: operationNumbersButton.changeNumber.selectedFruit.value)
            for (index, fruitNode) in foodArrayLeft.enumerated(){
                print("operation: \(operationNumbersButton.changeNumber.selectedFruit.value)")
                print("fruta: \(fruitNode.fruit.value)")
                //se o valor subtraido for igual ao valor de uma fruta do array da esquerda
                if operationNumbersButton.changeNumber.selectedFruit.value == fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded"{
                    //remove a fruta
                    fruitNode.node.removeFromParent()
                    foodArrayLeft.remove(at: index)
                    break
                } else if operationNumbersButton.changeNumber.selectedFruit.value > fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded" {
                    soma_left += foodArrayLeft[index].fruit.value
                    if soma_left < operationNumbersButton.changeNumber.selectedFruit.value {
                        deleteItemsArrayLeft.append(fruitNode.node)
                        
                    } else if soma_left == operationNumbersButton.changeNumber.selectedFruit.value {
                        deleteItemsArrayLeft.append(fruitNode.node)
                        foodArrayLeft.remove(at: index)
                        removeChildren(in: deleteItemsArrayLeft)
                        break
                    }
                    
                    else if soma_left > operationNumbersButton.changeNumber.selectedFruit.value {
                     
                        removeChildren(in: deleteItemsArrayLeft)
                        
                        let resto = soma_left - operationNumbersButton.changeNumber.selectedFruit.value
                        switch resto {
                        case 1:
                            print("virou fruta 1")
                            let texture = SKTexture(imageNamed: "fruit1")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit1
                            foodArrayLeft[index].node.run(action)
                        case 2:
                            print("virou fruta 2")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit2
                            foodArrayLeft[index].node.run(action)
                        case 3:
                            print("virou fruta 3")
                            let texture = SKTexture(imageNamed: "fruit3")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit3
                            foodArrayLeft[index].node.run(action)
                        case 4:
                            print("virou duas macas")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            let food: FruitNode = FruitNode(fruit: .fruit2)
                            foodArrayLeft[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                            foodArrayLeft[index].fruit = .fruit2
                            foodArrayLeft[index].node.run(action)
                            
                            food.node.zPosition = 20
                            food.node.position.y = foodArrayLeft[index].node.position.y
                            food.node.name = "foodAdded"
                            foodArrayLeft.append(food)
                            foodContLeft += frame.size.width / 28.66
                            food.node.position.x = foodArrayLeft[index].node.position.x + foodContLeft
                            addChild(food.node)
                        default:
                            print("default")
                            calculator.operationSubtraction(value: 1)
                            foodArrayLeft[index].fruit = .fruit1
                            foodArrayLeft[index].node = SKSpriteNode(imageNamed: "fruit1")
                        }
                        break
                    }
                    
                }
                // 3º caso: se o valor subtraido for menor que o valor da fruta, remove ela e coloca outra no lugar
                else if operationNumbersButton.changeNumber.selectedFruit.value < fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded" {
                    if fruitNode.fruit.value > aux_left {
                        cont_left = index
                        aux_left = fruitNode.fruit.value
                    }
                    else {
                        aux_left = aux_left - operationNumbersButton.changeNumber.selectedFruit.value
                    }
                    
                    if aux_left == fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded"{
                        aux_left -= operationNumbersButton.changeNumber.selectedFruit.value
                    }
                    print("aux: \(aux_left)")
                        //substitui
                    switch aux_left {
                    case 1:
                        print("virou fruta 1")
                        let texture = SKTexture(imageNamed: "fruit1")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit1
                        foodArrayLeft[cont_left].node.run(action)
                    case 2:
                        print("virou fruta 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit2
                        foodArrayLeft[cont_left].node.run(action)
                    case 3:
                        print("virou fruta 3")
                        let texture = SKTexture(imageNamed: "fruit3")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit3
                        foodArrayLeft[cont_left].node.run(action)
                    case 4:
                        print("virou duas frutas 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        let food: FruitNode = FruitNode(fruit: .fruit2)
                        foodArrayLeft[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        foodArrayLeft[cont_left].fruit = .fruit2
                        foodArrayLeft[cont_left].node.run(action)
                        
                        food.node.zPosition = 20
                        food.node.position.y = foodArrayLeft[cont_left].node.position.y
                        food.node.name = "foodAdded"
                        foodArrayLeft.append(food)
                        foodContLeft += frame.size.width / 14.33
                        food.node.position.x = foodArrayLeft[cont_left].node.position.x + foodContLeft
                        addChild(food.node)
                    default:
                        print("default")
                        foodArrayLeft[cont_left].fruit = .fruit1
                        foodArrayLeft[cont_left].node = SKSpriteNode(imageNamed: "fruit1")
                    }
                    break
                }
                
            }
            
            for (index, fruitNode) in foodArrayRight.enumerated(){
                print("operation: \(operationNumbersButton.changeNumber.selectedFruit.value)")
                print("fruta: \(fruitNode.fruit.value)")
                //se o valor subtraido for igual ao valor de uma fruta do array da esquerda
                if operationNumbersButton.changeNumber.selectedFruit.value == fruitNode.fruit.value{
                    print("entrou na remocao de uma fruta")
                    //remove a fruta
                    fruitNode.node.removeFromParent()
                    foodArrayRight.remove(at: index)
                    break
                } else if operationNumbersButton.changeNumber.selectedFruit.value > fruitNode.fruit.value {
                    soma_right += foodArrayRight[index].fruit.value
                    if soma_right < operationNumbersButton.changeNumber.selectedFruit.value {
                        deleteItemsArrayRight.append(fruitNode.node)
                        
                    } else if soma_right == operationNumbersButton.changeNumber.selectedFruit.value {
                        deleteItemsArrayRight.append(fruitNode.node)
                        foodArrayRight.remove(at: index)
                        removeChildren(in: deleteItemsArrayRight)
                        break
                    }
                    
                    else if soma_right > operationNumbersButton.changeNumber.selectedFruit.value {
                     
                        removeChildren(in: deleteItemsArrayRight)
                        
                        let resto = soma_right - operationNumbersButton.changeNumber.selectedFruit.value
                        switch resto {
                        case 1:
                            print("virou fruta 1")
                            let texture = SKTexture(imageNamed: "fruit1")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit1
                            foodArrayRight[index].node.run(action)
                            print(foodArrayRight)
                        case 2:
                            print("virou fruta 2")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit2
                            foodArrayRight[index].node.run(action)
                        case 3:
                            print("virou fruta 3")
                            let texture = SKTexture(imageNamed: "fruit3")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit3
                            foodArrayRight[index].node.run(action)
                        case 4:
                            print("virou duas macas")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            let food: FruitNode = FruitNode(fruit: .fruit2)
                            foodArrayRight[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                            foodArrayRight[index].fruit = .fruit2
                            foodArrayRight[index].node.run(action)
                            
                            food.node.zPosition = 20
                            food.node.position.y = foodArrayRight[index].node.position.y
                            food.node.name = "foodAdded"
                            foodArrayRight.append(food)
                            foodContRight += 30
                            food.node.position.x = foodArrayRight[index].node.position.x + foodContRight
                            addChild(food.node)
                        default:
                            print("default")
                            foodArrayRight[index].fruit = .fruit1
                            foodArrayRight[index].node = SKSpriteNode(imageNamed: "fruit1")
                        }
                        break
                    }
                    
                }
                // 3º caso: se o valor subtraido for menor que o valor da fruta, remove ela e coloca outra no lugar
                else if operationNumbersButton.changeNumber.selectedFruit.value <  fruitNode.fruit.value{
                    print("entrou na transformacao de uma fruta")
                    if fruitNode.fruit.value > aux_right {
                        cont_right = index
                        aux_right = fruitNode.fruit.value
                    }
                    else {
                        aux_right = aux_right - operationNumbersButton.changeNumber.selectedFruit.value
                    }
                    
                    if aux_right == fruitNode.fruit.value{
                        aux_right -= operationNumbersButton.changeNumber.selectedFruit.value
                    }
                    print("aux: \(aux_right)")
                        //substitui
                    switch aux_right {
                    case 1:
                        print("virou fruta 1")
                        let texture = SKTexture(imageNamed: "fruit1")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit1
                        foodArrayRight[cont_right].node.run(action)
                    case 2:
                        print("virou fruta 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit2
                        foodArrayRight[cont_right].node.run(action)
                    case 3:
                        print("virou fruta 3")
                        let texture = SKTexture(imageNamed: "fruit3")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit3
                        foodArrayRight[cont_right].node.run(action)
                    case 4:
                        print("virou duas frutas 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        let food: FruitNode = FruitNode(fruit: .fruit2)
                        foodArrayRight[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        foodArrayRight[cont_right].fruit = .fruit2
                        foodArrayRight[cont_right].node.run(action)
                        
                        food.node.zPosition = 20
                        food.node.position.y = foodArrayRight[cont_right].node.position.y
                        food.node.name = "foodAdded"
                        foodArrayRight.append(food)
                        foodContRight += 30
                        food.node.position.x = foodArrayRight[cont_right].node.position.x + foodContRight
                        addChild(food.node)
                    default:
                        print("default")
                        foodArrayRight[cont_right].fruit = .fruit1
                        foodArrayRight[cont_right].node = SKSpriteNode(imageNamed: "fruit1")
                    }
                    break
                }
                
            }
        }
    }
    
    func reduceFoodNumber(value: Int){
        var soma_left = 0
        var aux_left = 0
        var cont_left = 0
        var deleteItemsArrayLeft : [SKSpriteNode] = []
        
        var soma_right = 0
        var aux_right = 0
        var cont_right = 0
        var deleteItemsArrayRight : [SKSpriteNode] = []
        // Se o botao da operacao for subtracao
        //if operationButton.changeOperation.selectedOperation == .subtracao {
        
        // valor subtraído for maior que o peso da balanca, nao faz nada
        if value > DataModel.shared.weight - DataModel.shared.valueX {
            print("Numero maior que o peso, acao negada")
            endGame()
        }
        // valor subtraído for igual ao peso da balanca, nao faz nada
        else if value == DataModel.shared.weight {
            print("Numero igual ao peso, acao negada")
            endGame()
            
            //valor subtraído é menor que o peso da balanca
        } else {
            calculator.operationSubtraction(value: value)
            for (index, fruitNode) in foodArrayLeft.enumerated(){
                print("operation: \(value)")
                print("fruta: \(fruitNode.fruit.value)")
                //se o valor subtraido for igual ao valor de uma fruta do array da esquerda
                if value == fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded"{
                    //remove a fruta
                    fruitNode.node.removeFromParent()
                    foodArrayLeft.remove(at: index)
                    break
                } else if value > fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded" {
                    soma_left += foodArrayLeft[index].fruit.value
                    if soma_left < value {
                        deleteItemsArrayLeft.append(fruitNode.node)
                        
                    } else if soma_left == value {
                        deleteItemsArrayLeft.append(fruitNode.node)
                        foodArrayLeft.remove(at: index)
                        removeChildren(in: deleteItemsArrayLeft)
                        break
                    }
                    
                    else if soma_left > value {
                     
                        removeChildren(in: deleteItemsArrayLeft)
                        
                        let resto = soma_left - value
                        switch resto {
                        case 1:
                            print("virou fruta 1")
                            let texture = SKTexture(imageNamed: "fruit1")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit1
                            foodArrayLeft[index].node.run(action)
                        case 2:
                            print("virou fruta 2")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit2
                            foodArrayLeft[index].node.run(action)
                        case 3:
                            print("virou fruta 3")
                            let texture = SKTexture(imageNamed: "fruit3")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayLeft[index].fruit = .fruit3
                            foodArrayLeft[index].node.run(action)
                        case 4:
                            print("virou duas macas")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            let food: FruitNode = FruitNode(fruit: .fruit2)
                            foodArrayLeft[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                            foodArrayLeft[index].fruit = .fruit2
                            foodArrayLeft[index].node.run(action)
                            
                            food.node.zPosition = 20
                            food.node.position.y = foodArrayLeft[index].node.position.y
                            food.node.name = "foodAdded"
                            foodArrayLeft.append(food)
                            foodContLeft += frame.size.width / 28.66
                            food.node.position.x = foodArrayLeft[index].node.position.x + foodContLeft
                            addChild(food.node)
                        default:
                            print("default")
                            calculator.operationSubtraction(value: 1)
                            foodArrayLeft[index].fruit = .fruit1
                            foodArrayLeft[index].node = SKSpriteNode(imageNamed: "fruit1")
                        }
                        break
                    }
                    
                }
                // 3º caso: se o valor subtraido for menor que o valor da fruta, remove ela e coloca outra no lugar
                else if value < fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded" {
                    if fruitNode.fruit.value > aux_left {
                        cont_left = index
                        aux_left = fruitNode.fruit.value
                    }
                    else {
                        aux_left = aux_left - value
                    }
                    
                    if aux_left == fruitNode.fruit.value && foodArrayLeft[index].node.name != "incognitaAdded"{
                        aux_left -= value
                    }
                    print("aux: \(aux_left)")
                        //substitui
                    switch aux_left {
                    case 1:
                        print("virou fruta 1")
                        let texture = SKTexture(imageNamed: "fruit1")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit1
                        foodArrayLeft[cont_left].node.run(action)
                    case 2:
                        print("virou fruta 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit2
                        foodArrayLeft[cont_left].node.run(action)
                    case 3:
                        print("virou fruta 3")
                        let texture = SKTexture(imageNamed: "fruit3")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayLeft[cont_left].fruit = .fruit3
                        foodArrayLeft[cont_left].node.run(action)
                    case 4:
                        print("virou duas frutas 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        let food: FruitNode = FruitNode(fruit: .fruit2)
                        foodArrayLeft[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        foodArrayLeft[cont_left].fruit = .fruit2
                        foodArrayLeft[cont_left].node.run(action)
                        
                        food.node.zPosition = 20
                        food.node.position.y = foodArrayLeft[cont_left].node.position.y
                        food.node.name = "foodAdded"
                        foodArrayLeft.append(food)
                        foodContLeft += frame.size.width / 28.66
                        food.node.position.x = foodArrayLeft[cont_left].node.position.x + foodContLeft
                        addChild(food.node)
                    default:
                        print("default")
                        foodArrayLeft[cont_left].fruit = .fruit1
                        foodArrayLeft[cont_left].node = SKSpriteNode(imageNamed: "fruit1")
                    }
                    break
                }
                
            }
            
            for (index, fruitNode) in foodArrayRight.enumerated(){
                print("operation: \(value)")
                print("fruta: \(fruitNode.fruit.value)")
                //se o valor subtraido for igual ao valor de uma fruta do array da esquerda
                if value == fruitNode.fruit.value{
                    print("entrou na remocao de uma fruta")
                    //remove a fruta
                    fruitNode.node.removeFromParent()
                    foodArrayRight.remove(at: index)
                    break
                } else if value > fruitNode.fruit.value {
                    soma_right += foodArrayRight[index].fruit.value
                    if soma_right < value {
                        deleteItemsArrayRight.append(fruitNode.node)
                        
                    } else if soma_right == value {
                        deleteItemsArrayRight.append(fruitNode.node)
                        foodArrayRight.remove(at: index)
                        removeChildren(in: deleteItemsArrayRight)
                        break
                    }
                    
                    else if soma_right > value {
                     
                        removeChildren(in: deleteItemsArrayRight)
                        
                        let resto = soma_right - value
                        switch resto {
                        case 1:
                            print("virou fruta 1")
                            let texture = SKTexture(imageNamed: "fruit1")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit1
                            foodArrayRight[index].node.run(action)
                            print(foodArrayRight)
                        case 2:
                            print("virou fruta 2")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit2
                            foodArrayRight[index].node.run(action)
                        case 3:
                            print("virou fruta 3")
                            let texture = SKTexture(imageNamed: "fruit3")
                            let action = SKAction.setTexture(texture, resize: true)
                            foodArrayRight[index].fruit = .fruit3
                            foodArrayRight[index].node.run(action)
                        case 4:
                            print("virou duas macas")
                            let texture = SKTexture(imageNamed: "fruit2")
                            let action = SKAction.setTexture(texture, resize: true)
                            let food: FruitNode = FruitNode(fruit: .fruit2)
                            foodArrayRight[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                            foodArrayRight[index].fruit = .fruit2
                            foodArrayRight[index].node.run(action)
                            
                            food.node.zPosition = 20
                            food.node.position.y = foodArrayRight[index].node.position.y
                            food.node.name = "foodAdded"
                            foodArrayRight.append(food)
                            foodContRight += 30
                            food.node.position.x = foodArrayRight[index].node.position.x + foodContRight
                            addChild(food.node)
                        default:
                            print("default")
                            foodArrayRight[index].fruit = .fruit1
                            foodArrayRight[index].node = SKSpriteNode(imageNamed: "fruit1")
                        }
                        break
                    }
                    
                }
                // 3º caso: se o valor subtraido for menor que o valor da fruta, remove ela e coloca outra no lugar
                else if value <  fruitNode.fruit.value{
                    print("entrou na transformacao de uma fruta")
                    if fruitNode.fruit.value > aux_right {
                        cont_right = index
                        aux_right = fruitNode.fruit.value
                    }
                    else {
                        aux_right = aux_right - value
                    }
                    
                    if aux_right == fruitNode.fruit.value{
                        aux_right -= value
                    }
                    print("aux: \(aux_right)")
                        //substitui
                    switch aux_right {
                    case 1:
                        print("virou fruta 1")
                        let texture = SKTexture(imageNamed: "fruit1")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit1
                        foodArrayRight[cont_right].node.run(action)
                    case 2:
                        print("virou fruta 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit2
                        foodArrayRight[cont_right].node.run(action)
                    case 3:
                        print("virou fruta 3")
                        let texture = SKTexture(imageNamed: "fruit3")
                        let action = SKAction.setTexture(texture, resize: true)
                        foodArrayRight[cont_right].fruit = .fruit3
                        foodArrayRight[cont_right].node.run(action)
                    case 4:
                        print("virou duas frutas 2")
                        let texture = SKTexture(imageNamed: "fruit2")
                        let action = SKAction.setTexture(texture, resize: true)
                        let food: FruitNode = FruitNode(fruit: .fruit2)
                        foodArrayRight[index].node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        foodArrayRight[cont_right].fruit = .fruit2
                        foodArrayRight[cont_right].node.run(action)
                        
                        food.node.zPosition = 20
                        food.node.position.y = foodArrayRight[cont_right].node.position.y
                        food.node.name = "foodAdded"
                        foodArrayRight.append(food)
                        foodContRight += 30
                        food.node.position.x = foodArrayRight[cont_right].node.position.x + foodContRight
                        addChild(food.node)
                    default:
                        print("default")
                        foodArrayRight[cont_right].fruit = .fruit1
                        foodArrayRight[cont_right].node = SKSpriteNode(imageNamed: "fruit1")
                    }
                    break
                }
                
            }
        }
    }
    
    func divideFood(){
                
        print("caiu na divisao")
        
        if operationNumbersButton.changeNumber.selectedFruit.value != 2{
            endGame()
        }
        
        else{
            for (index, food) in foodArrayLeft.enumerated() {
                //Se houver uma incognita remove ela
                if food.node.name == "incognitaAdded" {
                    food.node.removeFromParent()
                    foodArrayLeft.remove(at: index)
                    break
                }
                else {
                    //Perde uma vida se houver algo alem da incognita na esquerda
                    endGame()
                    break
                }
                
            }
            
            reduceFoodNumber(value: DataModel.shared.valueX)
        }
        
        
        
        
    }
    
}
