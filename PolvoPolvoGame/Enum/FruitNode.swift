//
//  FrutaNode.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Micher on 31/01/24.
//

import Foundation
import SpriteKit

struct FruitNode {
    var fruit: FruitEnum
    var node: SKSpriteNode

    
    init(fruit: FruitEnum) {
        self.fruit = fruit
        self.node = SKSpriteNode(imageNamed: fruit.name())
    }
}
