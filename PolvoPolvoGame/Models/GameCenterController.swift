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
    
    private init(){}
    
    static let shared = GameCenterController()
    
    //func que autentifica o game center
    func authenticateGameCenter() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                
                return
            }
            if error != nil {
                
                return
            }
            self.accessPoint()
        }
    }
    
    //função que configura o ponto de acesso do game center
    func accessPoint() {
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true
    }
    
    //Função que salva um score no GameCenter
    func SaveData(gameplayData: GamePlayData) async {
        let name = "\(UUID())"
        
        do {
            let encoder = PropertyListEncoder()
            
            if let data = try? encoder.encode(gameplayData) {
                try await GKLocalPlayer.local.saveGameData(data, withName: name)
            }
        } catch {
            print("Error ENCODER: \(error.localizedDescription)")
        }
    }
    
    //Função que busca um score no gamecenter
    func loadData( completion: @escaping (GamePlayData)->Void) {
        GKLocalPlayer.local.fetchSavedGames { games, error in
            if let games = games {
                var game: GKSavedGame?
                for currentGame in games {
                    if game == nil || game?.modificationDate ?? Date() < currentGame.modificationDate ?? Date() {
                        game = currentGame
                    }
                }
                if let game = game {
                    Task{
                        await self.load(game: game, completion: completion)
                    }
                }
            }
        }
    }
    
    //função que complementa a função loadData
    func load(game: GKSavedGame, completion: (GamePlayData) -> Void) async {
        let data: Data
        do {
            data = try await game.loadData()
        } catch {
            print("Error: \(error.localizedDescription).")
            return
        }
        
        let decoder = PropertyListDecoder()
        
        do {
            let gameData = try decoder.decode(GamePlayData.self, from: data)
            completion(gameData)
        } catch {
            print("Error DECODER: \(error.localizedDescription).")
            return
        }
    }
}
