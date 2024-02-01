//
//  EndScene.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 31/01/24.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    var endData: EndData = EndData(points: DataModel.shared.contadorEquacoes, bPoints: 0)
    
    override func didMove(to view: SKView) {
        endData.node.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(endData.node)
    }
}
