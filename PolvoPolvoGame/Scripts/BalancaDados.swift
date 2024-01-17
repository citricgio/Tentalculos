//
//  BandejaDados.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation

class BalancaDados {
    
    public var gerador: GeradorPesos = GeradorPesos()
    
    public var balanca_direita_travada: Bool = false
    
    public var balanca_esquerda_travada: Bool = false
    
    public var peso_direita: Int = 0
    
    public var peso_esquerda: Int = 0
    
    
    func adicionar_fruta_direita(fruta: FrutaEnum){
        if !(peso_direita == gerador.valor_cada_lado){
            peso_direita += fruta.rawValue
            balanca_direita_travada = true
        }
        print(peso_direita)
    }
    
    func adicionar_fruta_esquerda(fruta: FrutaEnum){
        if !(peso_esquerda == gerador.valor_cada_lado){
            peso_esquerda += fruta.rawValue
            balanca_esquerda_travada = true
        }
        print(peso_esquerda)
    }
    
    
}
