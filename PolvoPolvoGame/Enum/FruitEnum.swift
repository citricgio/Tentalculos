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
    case fruit4
    case incognita
    
    func name() -> String {
        switch self {
        case .fruta1: return "fruit1"
        case .fruta2: return "fruit2"
        case .fruta3: return "fruit3"
        case .fruta5: return "fruit5"
        case .incognita: return "incognita"
        case .empty: return "empty"

            
        }
    }
    
    func toNode() -> FrutaNode {
        return FrutaNode(fruta: self)
    }
    
    var valor: Int {
        
        switch self {
        case .fruta1: 1
        case .fruta2: 2
        case .fruta3: 3
        case .fruta5: 5
        case .incognita: DataModel.shared.valorX
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



