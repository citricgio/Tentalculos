//
//  GeradorEquacoes.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

//Gerar as equações para o usuário igualar
class GeradorPesos {

    //valor máximo em que se pode dar para o valor de X ou variável
    public var valor_max: Int = 5
    
    //Gera uma equação mais simples, sem multiplicar a Variável
    func Gerar_Numeros_Basico(){
        DataModel.shared.valorX = Int.random(in: 1..<valor_max) //randomizador do valor de X
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valorX + 1)..<(2*valor_max)) //randomizador do valor de cada lado da equação a partir do valor de X
        
        DataModel.shared.b = DataModel.shared.peso-DataModel.shared.valorX //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.peso //Fala qual é o valor que iguala na equação
        DataModel.shared.valorMultiplicador = 1
         
        print(DataModel.shared.valorX)
        print(DataModel.shared.peso)
    }
    
    //Gera uma equação um pouco mais complexa com um valor multiplicando a variável
    func Gerar_Numeros_Intermediario(){
        DataModel.shared.valorX = Int.random(in: 1..<valor_max) //randomizador do valor de X
        DataModel.shared.valorMultiplicador = Int.random(in: 1...2) //randomizador do valor que multiplica X
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valorMultiplicador*DataModel.shared.valorX + 1)..<(2*valor_max)) //randomizador do valor de cada lado da equação
        
        DataModel.shared.b = DataModel.shared.peso-(DataModel.shared.valorX*DataModel.shared.valorMultiplicador) //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.peso //Fala qual é o valor que iguala na equação
        
        print(DataModel.shared.valorX)
        print(DataModel.shared.valorMultiplicador)
        print(DataModel.shared.peso)
    }
    
    //Gera uma equação avançada com variáveis dos dois lados
    func Gerar_Numeros_Avancado(){
        DataModel.shared.valorX = Int.random(in: 1..<valor_max) //randomizador do valor de X
        DataModel.shared.valorMultiplicador = Int.random(in: 1...4) //randomizador do valor que multiplica X
        DataModel.shared.peso = Int.random(in: (DataModel.shared.valorMultiplicador*DataModel.shared.valorX + 1)..<(2*valor_max)) //randomizador do valor de cada lado da equação
        
        DataModel.shared.b = DataModel.shared.peso-(DataModel.shared.valorX*DataModel.shared.valorMultiplicador) //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.peso-(DataModel.shared.valorX*(DataModel.shared.valorMultiplicador-1))//Fala qual é o valor que iguala na equação
        
        print(DataModel.shared.valorX)
        print(DataModel.shared.valorMultiplicador)
        print(DataModel.shared.peso)
    }
    
    //monta o texto da equação Basica e Intermediária
    func Montar_Texto(){
        
        DataModel.shared.textoEquacao = "\(DataModel.shared.b) + \(DataModel.shared.valorMultiplicador)x = \(DataModel.shared.peso)"
        
        print(DataModel.shared.textoEquacao)
        
    }
    
    //monta o texto da equação avançada
    func Montar_Texto_avançado() {
        
        DataModel.shared.textoEquacao = "\(DataModel.shared.b) + \(DataModel.shared.valorMultiplicador)x = \(DataModel.shared.c) + \(DataModel.shared.valorMultiplicador-1)x"
        
        print(DataModel.shared.textoEquacao)
    }
    
    
    
}
