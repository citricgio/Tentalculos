//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.

import Foundation
import SwiftUI

//essa classe vai fazer as operações utilizando o contador
class Calculadora {
    
    var fruit: FruitEnum = .fruit1
    
    //operação de subtração
    func Subtracao(valor: Int){
        DataModel.shared.weight -= valor
        print("peso: \(DataModel.shared.weight)")
        
    }
    
    //operação de divisão
    func Divisao(fruit: FruitEnum){
        if (DataModel.shared.weight / fruit.valor >= 0) {
            DataModel.shared.weight = DataModel.shared.weight / fruit.valor
        }
        print(DataModel.shared.weight)
    }
    
}


