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
    
    public var peso_direita: Int = 0
    
    public var peso_esquerda: Int = 0
    
    
    func adicionar_fruta_direita(fruta: FrutaEnum){
        if !(peso_direita == DataModel.shared.peso){
            peso_direita += fruta.rawValue
        }
        else{
            balanca_direita_travada = true
        }
        print(peso_direita)
    }
    
    func adicionar_fruta_esquerda(fruta: FrutaEnum){
        if !(peso_esquerda == DataModel.shared.peso){
            peso_esquerda += fruta.rawValue
        }
        else{
            balanca_esquerda_travada = true
        }
        print(peso_esquerda)
    }
    
    
}
