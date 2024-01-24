//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.

import Foundation
import SwiftUI

//essa classe vai fazer as operações utilizando o contador
class Calculadora {
    
    
    //operação de subtração
    func Subtracao(){
        if (DataModel.shared.peso - DataModel.shared.numerosBotao.valor >= 0){
            DataModel.shared.peso -= DataModel.shared.numerosBotao.valor
        }
        print(DataModel.shared.peso)
    }
    
    //operação de divisão
    func Divisao(){
        if (DataModel.shared.peso / DataModel.shared.numerosBotao.valor >= 0) {
            DataModel.shared.peso = DataModel.shared.peso / DataModel.shared.numerosBotao.valor
        }
        print(DataModel.shared.peso)
    }
    
}


