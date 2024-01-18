//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

class Calculadora {
    var operacoesEnum: OperacoesEnum
    
    init(operacoesEnum: OperacoesEnum) {
        self.operacoesEnum = operacoesEnum
    }
    
    func Subtracao(){
        DataModel.shared.peso_direita = DataModel.shared.peso_direita-DataModel.shared.contador
        DataModel.shared.peso_esquerda = DataModel.shared.peso_esquerda-DataModel.shared.contador
    }
    
    func Divisao(){
        DataModel.shared.peso_direita = DataModel.shared.peso_direita/DataModel.shared.contador
        DataModel.shared.peso_esquerda = DataModel.shared.peso_esquerda/DataModel.shared.contador
    }
    
}
