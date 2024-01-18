//
//  BandejaDados.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

class BalancaDados {
    
    public var balanca_direita_travada: Bool = false
    
    public var balanca_esquerda_travada: Bool = false
    
//MARK: Corrigir a logica da balanca com o gerador novo
    
    
    func adicionar_fruta_direita(fruta: FrutaEnum){
        if !(DataModel.shared.peso_direita == DataModel.shared.peso-DataModel.shared.valorX){
            DataModel.shared.peso_direita += fruta.rawValue
        }
        else{
            balanca_direita_travada = true
        }
        print(DataModel.shared.peso_direita)
    }
    
    func adicionar_fruta_esquerda(fruta: FrutaEnum){
        if !(DataModel.shared.c == DataModel.shared.peso){
            DataModel.shared.peso_esquerda += fruta.rawValue
        }
        else{
            balanca_esquerda_travada = true
        }
        print(DataModel.shared.peso_esquerda)
    }
    
}
