// GameScene.swift
// BluebinProject
//
// Created by Giovanna Micher on 19/01/24.
//
import Foundation
import SpriteKit

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
    let foodTrayLeft = SKSpriteNode()
    let foodTrayRight = SKSpriteNode()
    
    // variáveis que armazenam o local da posição da bandeja de quando rotaciona o braço do polvo
    var trayPositionUpY: CGFloat = 500
    var trayPositionDownY: CGFloat = 300
    
    // variáveis que indicam se tem comida na bandeja ou não
    var isInTrayLeft: Bool = false
    var isInTrayRight: Bool = false
    
    // braço do polvo
    let octopusArm = SKSpriteNode()
    
    // spawners da onde saem as comidas
    let spawner1 = SKSpriteNode()
    let spawner2 = SKSpriteNode()
    let spawner3 = SKSpriteNode()
    
    // localização dos spawners
    var spawnLocation1 = CGPoint(x:80, y: 100)
    var spawnLocation2 = CGPoint(x:340, y: 100)
    var spawnLocation3 = CGPoint(x:200, y: 100)
    
    // variável que indica o ângulo dos braços do polvo
    var angle: CGFloat = 0
    
    // variável que indica se tem X na bandeja ou não
    var hasX: Bool = false
    
    // função que carrega as coisas na tela (quando a cena do sprite kit é movida para a tela)
    override func didMove(to view: SKView) {
        setupGame()
        setupSpawners()
        setupArm()
        setupTargets()
        backgroundColor = .white
        
        let button = SpriteButtonNumbers {
            print("botao 1 deu certoo")
        }
        let button2 = SpriteButtonOperation {
            print("botao 2 funciona")
        }
        
        addChild(button)
        addChild(button2)
    }
    
    // função que faz as bases iniciais do jogo
    func setupGame(){
        gerador.Gerar_Numeros_Basico() // gera uma equação aleatória
    }
    
    // função que calcula o ângulo de rotação do braço do polvo (vai de -45º até 45º)
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
    
    // função que coloca o braço do polvo na tela
    func setupArm(){
        octopusArm.color = SKColor.black
        octopusArm.size = CGSize(width: 400, height: 200)
        octopusArm.position = CGPoint(x: 200 , y: 400)
        octopusArm.zPosition = 5
        
        addChild(octopusArm)
    }
    
    // função que coloca as bandejas na tela
    func setupTargets(){
        foodTrayLeft.color = SKColor.yellow
        foodTrayLeft.size = CGSize(width: 200, height: 200)
        foodTrayLeft.position.y = octopusArm.position.y + 100
        foodTrayLeft.position.x = 80
        foodTrayLeft.zPosition = 10
        
        foodTrayRight.color = SKColor.yellow
        foodTrayRight.size = CGSize(width: 200, height: 200)
        foodTrayRight.position = CGPoint(x: 340, y: 200)
        foodTrayRight.position.y = octopusArm.position.y + 100
        foodTrayRight.zPosition = 10
        
        addChild(foodTrayLeft)
        addChild(foodTrayRight)
    }
    
    // função que coloca os spawners na tela
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
    
    // função que move as bandejas de acordo com a posição do braço do polvo
    func rotate(angleRotation: CGFloat){
        
        let rotateAction = SKAction.rotate(toAngle: angle, duration: 1, shortestUnitArc: true)
        octopusArm.run(rotateAction)
        
        if DataModel.shared.peso_lado_esquerdo < DataModel.shared.peso_lado_direito{
            
            let moveAction = SKAction.moveTo(y: trayPositionUpY, duration: 1)
            self.foodTrayLeft.run(moveAction)
            
            let moveAction2 = SKAction.moveTo(y: trayPositionDownY, duration: 1)
            self.foodTrayRight.run(moveAction2)
            
        } else if DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso_lado_direito {
            let moveAction = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2, duration: 1)
            self.foodTrayLeft.run(moveAction)
            
            let moveAction2 = SKAction.moveTo(y: (trayPositionUpY + trayPositionDownY) / 2, duration: 1)
            self.foodTrayRight.run(moveAction2)
            
        } else {
            let moveAction = SKAction.moveTo(y: trayPositionDownY, duration: 1)
            self.foodTrayLeft.run(moveAction)
            
            let moveAction2 = SKAction.moveTo(y: trayPositionUpY, duration: 1)
            self.foodTrayRight.run(moveAction2)
        }
    }
    
    //função que retorna a fruta para o local de spawn
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
    
    // função que é chamada a cada framde do jogo e atualiza a cena
    override func update(_ currentTime: TimeInterval) {
        calculateAngle()
        
        // Se a comida entrar na bandeja, a posição da comida vai ser atualizada, as comidas são posicionadas lado a lado quando adicionadas mais de uma
        if isInTrayLeft {
            foodNode.position.x = (foodTrayLeft.position.x - 50) + foodContLeft
            rotate(angleRotation: angle)
            
        } else if isInTrayRight {
            foodNode.position.x = (foodTrayRight.position.x - 50) + foodContRight
            rotate(angleRotation: angle)
        }
        
        // atualiza a posição da comida de acordo com a posição da bandeja
        for food in foodArrayLeft {
            food.position.y = foodTrayLeft.position.y
        }
        for food in foodArrayRight {
            food.position.y = foodTrayRight.position.y
        }
        
        // TODO: spawnar botao de proximo
        // quando ambas as balanças estão travadas, aparece o botão de próximo
        if DataModel.shared.balanca_direita_travada && DataModel.shared.balanca_esquerda_travada {
            //funcao spawnar botao de proximo
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
        
        if foodTrayLeft.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_esquerdo <= DataModel.shared.peso { // condição que adiciona uma fruta na bandeja da esquerda desde que ela não seja maior que o valor máximo de cada lado da equação
            
            if foodNode.name == "food" || foodNode.name == "incognita" {
                balanca.adicionar_fruta_esquerda(fruta: food)
                if !(DataModel.shared.balanca_esquerda_travada){ // se a bandeja não estiver travada, adiciona fruta
                    if foodNode.name == "incognita"{ // condição que verifica que tem incógnita na bandeja da esquerda
                        hasX = true
                    }
                    foodNode.name = "foodAdded"
                    isInTrayLeft = true
                    foodArrayLeft.append(foodNode)
                    foodContLeft += 10
                } else {
                    returnToSpawn()
                }
            }
        } else if foodTrayRight.frame.contains(foodNode.position) && food.valor + DataModel.shared.peso_lado_direito <= DataModel.shared.peso{ // condição que adiciona uma fruta na bandeja da direita desde que ela não seja maior que o valor máximo de cada lado da equação
            
            if foodNode.name == "food"{
                balanca.adicionar_fruta_direita(fruta: food)
                if !(DataModel.shared.balanca_direita_travada){ // se a bandeja não estiver travada, adiciona fruta
                    foodNode.name = "foodAdded"
                    isInTrayRight = true
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
