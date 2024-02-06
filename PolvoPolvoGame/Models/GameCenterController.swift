//
//  GameCenterController.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 05/02/24.
//

import Foundation
import GameKit

//Classe que tem todas as funções ligadas ao GameCenter
class GameCenterController {
    
    static let shared = GameCenterController()
    
    //função que instancia o points com o valor do contador de equações
    var points: Int = DataModel.shared.contadorEquacoes
    
    //func que autentifica o game center
    func authenticateGameCenter() {
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
    func acessPoint() {
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }
    
    //Envia um Score para os leaderboards
    func scoreToLeaderboard() {
        GKLeaderboard.submitScore(self.points, context: 0, player: GKLocalPlayer.local,
                                  leaderboardIDs: ["my.recurring.leaderboard.000"]) { error in
            if error != nil {
                print("Error: \(error!.localizedDescription).")
            }
        }
    }
    
    //Acessa o BestScore e coloca no código
    func accessBestScore() {
        GKLeaderboard.loadLeaderboards(IDs:["my.recurring.leaderboard.id"]) { (fetchedLBs, error) in
            if let current = fetchedLBs?.first {

                current.loadPreviousOccurrence { (prevOccurrence, error) in
//                    DataModel.shared.bestPointsLabel = "\(prevOccurrence)"
                    // Do something with the previous occurrence
                }
            }
        }
    }
    
//    func loadLeaderboards() async {
//        let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: ["my.leaderboard.000"])
//    }
}
