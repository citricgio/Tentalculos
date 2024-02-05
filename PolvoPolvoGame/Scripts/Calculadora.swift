//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.

import Foundation
import SwiftUI

//essa classe vai fazer as operações utilizando o contador
class Calculadora {
    
    var fruta: FrutaEnum = .fruta1
    
    //operação de subtração
    func Subtracao(valor: Int){
        DataModel.shared.peso -= valor
        print("peso: \(DataModel.shared.peso)")
        
    }
    
    //operação de divisão
    func Divisao(fruta: FrutaEnum){
        if (DataModel.shared.peso / fruta.valor >= 0) {
            DataModel.shared.peso = DataModel.shared.peso / fruta.valor
        }
        print(DataModel.shared.peso)
    }
    
}


