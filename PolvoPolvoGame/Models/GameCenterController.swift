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
    func accessPoint() {
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }
    
    //Envia um Score para os leaderboards
    func scoreToLeaderboard() {
 //       print(self.points)
        GKLeaderboard.loadLeaderboards(IDs:["000"]) { (fetchedLBs, error) in
//            print(self.points)
            guard let lb = fetchedLBs?.first else {
                print(self.points)
                return }
            guard let endDate = lb.startDate?.addingTimeInterval(lb.duration), endDate > Date() else { 
                print(self.points)
                return }
            lb.submitScore(self.points, context: 0, player: GKLocalPlayer.local) { error in
 //               print(self.points)
            }
        }
    }
    
    //Acessa o BestScore e coloca no código
    func accessBestScore() {
        GKLeaderboard.loadLeaderboards(IDs:["000"]) { (fetchedLBs, error) in
            if let current = fetchedLBs?.first {
                
                current.loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) { entry, entries, error in
                    if let entrySafe = entry{
                        DataModel.shared.bestPoints = entrySafe.score
                    }
                }
            }
        }
    }
    
    func atualizarVariavel() {
        points = DataModel.shared.contadorEquacoes
    }
}
