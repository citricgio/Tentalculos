//
//  BandejaDados.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

//Cuidar da logica quando o usuário estiver montando a balança e travar ela
class BalancaDados {
    
    var fruta: FrutaEnum = .fruta1
    
    //função que adiciona as frutas no lado direito da balança e trava quando o valor do lado direito for o peso necessário para a balança
    func adicionar_fruta_direita(fruta: FrutaEnum){
        if !(DataModel.shared.peso_lado_direito == DataModel.shared.peso){
            DataModel.shared.peso_lado_direito += fruta.valor
            print("peso na direita: \(DataModel.shared.peso_lado_direito)")
        }
        else{
            DataModel.shared.balanca_direita_travada = true
        }
        
    }
    
    //função que adiciona as frutas no lado esquerdo da balança e trava quando o valor do lado direito for igual o do peso
    func adicionar_fruta_esquerda(fruta: FrutaEnum){
        if !(DataModel.shared.peso_lado_esquerdo == DataModel.shared.peso){
            DataModel.shared.peso_lado_esquerdo += fruta.valor
            print("peso na esquerda: \(DataModel.shared.peso_lado_esquerdo)")
        }
        else{
            DataModel.shared.balanca_esquerda_travada = true
        }
        
    }
    
}
