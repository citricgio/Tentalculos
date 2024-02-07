//
//  FrutasEnum.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation

enum OperationsEnum {
    case subtraction
    case division
    var name: String {
        switch self {
        case .subtraction: "-"
        case .division: "/"
        }
    }
}
