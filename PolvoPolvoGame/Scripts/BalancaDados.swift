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
    
    //variáveis contam as frutas de cada lado quando o usuário estiver montando a balança
    var peso_direita: Int = 0
    var peso_esquerda: Int = 0
    
    //função que adiciona as frutas no lado direito da balança e trava quando o valor do lado direito for o peso necessário para a balança
    func adicionar_fruta_direita(fruta: FrutaEnum){
        if !(peso_direita == DataModel.shared.b){
            peso_direita += fruta.rawValue
        }
        else{
            DataModel.shared.balanca_direita_travada = true
        }
        print(peso_direita)
    }
    
    //função que adiciona as frutas no lado esquerdo da balança e trava quando o valor do lado direito for igual o do peso
    func adicionar_fruta_esquerda(fruta: FrutaEnum){
        if !(peso_esquerda == DataModel.shared.peso){
            peso_esquerda += fruta.rawValue
        }
        else{
            DataModel.shared.balanca_esquerda_travada = true
        }
        print(peso_esquerda)
    }
    
}
