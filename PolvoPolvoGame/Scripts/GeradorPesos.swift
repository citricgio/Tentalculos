//
//  GeradorEquacoes.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation

class GeradorPesos {

    public var valor_max: Int = 5
    public var valor_cada_lado: Int = 0
    public var valor_de_x_esquerda: Int = 0

    
    func Gerar_Numeros_Basico(){
        valor_de_x_esquerda = Int.random(in: 1..<valor_max)
        valor_cada_lado = Int.random(in: (valor_de_x_esquerda + 1)..<(2*valor_max))
        
        print(valor_de_x_esquerda)
        print(valor_cada_lado)
    }
    
    func Montar_Texto(){
        //Text("\(coeficiente) + x = \(valor_cada_lado)")
        let textoEquacao: String = "\(valor_cada_lado - valor_de_x_esquerda) + \(valor_de_x_esquerda)x = \(valor_cada_lado)"
        print(textoEquacao)
    }
    
    
    
}
