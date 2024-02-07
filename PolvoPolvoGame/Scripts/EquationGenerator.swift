//
//  GeradorEquacoes.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

//Gerar as equações para o usuário igualar
class EquationGenerator {

    //valor máximo em que se pode dar para o valor de X ou variável
    public var maxValue: Int = 5
    
    //Gera uma equação mais simples, sem multiplicar a Variável
    func generateBasicEquation(){
        DataModel.shared.valueX = Int.random(in: 1..<maxValue) //randomizador do valor de X
        DataModel.shared.weight = Int.random(in: (DataModel.shared.valueX + 1)..<(2*maxValue)) //randomizador do valor de cada lado da equação a partir do valor de X
        
        DataModel.shared.b = DataModel.shared.weight-DataModel.shared.valueX //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.weight //Fala qual é o valor que iguala na equação
        DataModel.shared.valueMultiplier = 1
         
        print(DataModel.shared.valueX)
        print(DataModel.shared.weight)
    }
    
    //Gera uma equação um pouco mais complexa com um valor multiplicando a variável
    func generateIntermidiateEquation(){
        DataModel.shared.valueX = Int.random(in: 1..<maxValue) //randomizador do valor de X
        DataModel.shared.valueMultiplier = Int.random(in: 1...2) //randomizador do valor que multiplica X
        DataModel.shared.weight = Int.random(in: (DataModel.shared.valueMultiplier*DataModel.shared.valueX + 1)..<(2*maxValue)) //randomizador do valor de cada lado da equação
        
        DataModel.shared.b = DataModel.shared.weight-(DataModel.shared.valueX*DataModel.shared.valueMultiplier) //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.weight //Fala qual é o valor que iguala na equação
        
        print(DataModel.shared.valueX)
        print(DataModel.shared.valueMultiplier)
        print(DataModel.shared.weight)
    }
    
    //Gera uma equação avançada com variáveis dos dois lados
    func generateAdvancedEquation(){
        DataModel.shared.valueX = Int.random(in: 1..<maxValue) //randomizador do valor de X
        DataModel.shared.valueMultiplier = Int.random(in: 1...4) //randomizador do valor que multiplica X
        DataModel.shared.weight = Int.random(in: (DataModel.shared.valueMultiplier*DataModel.shared.valueX + 1)..<(2*maxValue)) //randomizador do valor de cada lado da equação
        
        DataModel.shared.b = DataModel.shared.weight-(DataModel.shared.valueX*DataModel.shared.valueMultiplier) //calcula o valor que soma a variável na equação
        DataModel.shared.c = DataModel.shared.weight-(DataModel.shared.valueX*(DataModel.shared.valueMultiplier-1))//Fala qual é o valor que iguala na equação
        
        print(DataModel.shared.valueX)
        print(DataModel.shared.valueMultiplier)
        print(DataModel.shared.weight)
    }
    
    //monta o texto da equação Basica e Intermediária
    func assembleEquation(){
        
        DataModel.shared.equationText = "\(DataModel.shared.b) + \(DataModel.shared.valueMultiplier)? = \(DataModel.shared.weight)"
        
        print(DataModel.shared.equationText)
        
    }
    
    //monta o texto da equação avançada
    func assembleAdvancedEquation() {
        
        DataModel.shared.equationText = "\(DataModel.shared.b) + \(DataModel.shared.valueMultiplier)? = \(DataModel.shared.c) + \(DataModel.shared.valueMultiplier-1)?"
        
        print(DataModel.shared.equationText)
    }
    
    
    
}
