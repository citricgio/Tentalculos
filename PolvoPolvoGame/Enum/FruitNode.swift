//
//  FrutaNode.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Micher on 31/01/24.
//

import Foundation
import SpriteKit

struct FruitNode {
    let fruit: FruitEnum
    let node: SKSpriteNode
    
    init(fruit: FruitEnum) {
        self.fruit = fruit
        self.node = SKSpriteNode(imageNamed: fruit.name())
    }
}
