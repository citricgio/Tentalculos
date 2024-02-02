//
//  FrutaNode.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Micher on 31/01/24.
//

import Foundation
import SpriteKit

struct FrutaNode: Hashable {
    var fruta: FrutaEnum
    var node: SKSpriteNode
    
    init(fruta: FrutaEnum) {
        self.fruta = fruta
        self.node = SKSpriteNode(imageNamed: fruta.name())
    }
}
