//
//  GeradorEquacoes.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

class GeradorPesos {

    public var valor_max: Int = 5
    
    func Gerar_Numeros_Basico(){
        DataModel.shared.valorX = Int.random(in: 1..<valor_max)
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valorX + 1)..<(2*valor_max))
        
        DataModel.shared.b = DataModel.shared.peso-DataModel.shared.valorX
        DataModel.shared.c = DataModel.shared.peso
        
        print(DataModel.shared.valorX)
        print(DataModel.shared.peso)
    }
    func Gerar_Numeros_Intermediario(){
        DataModel.shared.valorX = Int.random(in: 1..<valor_max)
        DataModel.shared.valorMultiplicador = Int.random(in: 1..<2)
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valorMultiplicador*DataModel.shared.valorX + 1)..<(2*valor_max))
        
        DataModel.shared.b = DataModel.shared.peso-DataModel.shared.valorX
        DataModel.shared.c = DataModel.shared.peso
        
        print(DataModel.shared.valorX)
        print(DataModel.shared.valorMultiplicador)
        print(DataModel.shared.peso)
    }
    func Montar_Texto(){
        //Text("\(coeficiente) + x = \(valor_cada_lado)")
        let textoEquacao: String = "\(DataModel.shared.b) + \(DataModel.shared.valorMultiplicador)x = \(DataModel.shared.peso)"
        print(textoEquacao)
    }
    
    
    
}
