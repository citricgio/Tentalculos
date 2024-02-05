//
//  GameCenterController.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 05/02/24.
//

import Foundation
import GameKit

class GameCenterController {
    
    static let shared = GameCenterController()
    
    //func que autentifica o game center
    func autenticarGameCenter() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                return
            }
            if error != nil {
                return
            }
        }
    }
    
    //função que configura o ponto de acesso do game center
    func pontoDeAcesso() {
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }
    
    
}
