//
//  FontesEnum.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 02/02/24.
//

import Foundation

//um enum para padronizar o tamanho das fontes e qual fonte usar
enum FontesEnum {
    
    case buttons
    case numbers
    case points
    case labelPoints
    case squareButtons
    case appTitle
    
    var size: CGFloat {
        switch self {
        case .buttons: return 28
        case .numbers: return 36
        case .points: return 24
        case .labelPoints: return 36
        case .squareButtons: return 40
        case .appTitle: return 50
        }
    }
    
    var font: String {
        switch self {
        case .points: return "Istok Web"
        default: return "IstokWeb-Bold"
        }
    }
}
