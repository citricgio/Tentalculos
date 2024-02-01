//
//  FrutaNode.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Micher on 31/01/24.
//

import Foundation
import SpriteKit

struct FrutaNode {
    let fruta: FrutaEnum
    let node: SKSpriteNode
    
    init(fruta: FrutaEnum) {
        self.fruta = fruta
        self.node = SKSpriteNode(imageNamed: fruta.name())
    }
}
