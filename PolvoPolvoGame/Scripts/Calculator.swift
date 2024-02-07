//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.

import Foundation
import SwiftUI

//essa classe vai fazer as operações utilizando o contador
class Calculator {
    
    var fruit: FruitEnum = .fruit1
    
    //operação de subtração
    func operationSubtraction(value: Int){
        DataModel.shared.weight -= value
        print("peso: \(DataModel.shared.weight)")
        
    }
    
    //operação de divisão
    func operatioDivision(fruit: FruitEnum){
        if (DataModel.shared.weight / fruit.value >= 0) {
            DataModel.shared.weight = DataModel.shared.weight / fruit.value
        }
        print(DataModel.shared.weight)
    }
    
}


