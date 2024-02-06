//
//  FrutasEnum.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation

enum OperationsEnum {
    case subtraction
    case divisao
    var name: String {
        switch self {
        case .subtracao: "-"
        case .divisao: "/"
        }
    }
}
