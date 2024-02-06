//
//  FrutasEnum.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SpriteKit

//enum que vai falar qual o valor de cada fruta selecionada
enum FruitEnum: CaseIterable {
    case empty
    case fruit1
    case fruit2
    case fruit3
    case fruit5
    case unknown
    
    func name() -> String {
        switch self {
        case .fruit1: return "fruit1"
        case .fruit2: return "fruit2"
        case .fruit3: return "fruit3"
        case .fruit5: return "fruit5"
        case .unknown: return "incognita"
        case .empty: return "empty"

            
        }
    }
    
    func toNode() -> FruitNode {
        return FruitNode(fruit: self)
    }
    
    var valor: Int {
        
        switch self {
        case .fruit1: 1
        case .fruit2: 2
        case .fruit3: 3
        case .fruit5: 5
        case .unknown: DataModel.shared.valueX
        case .empty: -1
        }
    }
//    var nome: String {
//        switch self {
//        case .fruta1:
//            "fruit1"
//            
//        case .fruta2:
//            "fruit2"
//
//        case .fruta3:
//            "fruit3"
//
//        case .fruta5:
//            "fruit5"
//            
//        case .incognita:
//            "incognita"
//            
//        
//        }
//    }
}



