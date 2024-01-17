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
        DataModel.shared.valor_variavel = Int.random(in: 1..<valor_max)
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valor_variavel + 1)..<(2*valor_max))
        
        print(DataModel.shared.valor_variavel)
        print(DataModel.shared.peso)
    }
    
    func Montar_Texto(){
        //Text("\(coeficiente) + x = \(valor_cada_lado)")
        let textoEquacao: String = "\(DataModel.shared.peso - DataModel.shared.valor_variavel) + \(DataModel.shared.valor_variavel)x = \(DataModel.shared.peso)"
        print(textoEquacao)
    }
    
    
    
}
