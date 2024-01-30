//
//  FrutasEnum.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SpriteKit

//enum que vai falar qual o valor de cada fruta selecionada
enum FrutaEnum: CaseIterable {
    case fruta1
    case fruta2
    case fruta3
    case fruta5
    case incognita
    
    var valor: Int {
        switch self {
            
        case .fruta1: 1
        case .fruta2: 2
        case .fruta3: 3
        case .fruta5: 5
        case .incognita: DataModel.shared.valorX
            
        }
    }
    var nome: String {
        switch self {
        case .fruta1:
            "fruit1"
            
        case .fruta2:
            "fruit2"

        case .fruta3:
            "fruit3"

        case .fruta5:
            "fruit5"
            
        case .incognita:
            "incognita"
        }
    }
}



