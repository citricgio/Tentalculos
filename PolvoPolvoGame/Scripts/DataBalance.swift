//
//  BandejaDados.swift
//  gerador_equacoes
//
//  Created by Thiago Liporace on 16/01/24.
//

import Foundation
import SwiftUI

//Cuidar da logica quando o usuário estiver montando a balança e travar ela
class DataBalance {
    
    var fruit: FruitEnum = .fruit1
    
    //função que adiciona as frutas no lado direito da balança e trava quando o valor do lado direito for o peso necessário para a balança
    func addRightFruit(fruit: FruitEnum){
        if !(DataModel.shared.weightRightSide == DataModel.shared.weight){
            DataModel.shared.weightRightSide += fruit.valor
            print("peso na direita: \(DataModel.shared.weightRightSide)")
        }
        else{
            DataModel.shared.rightBalanceLocked = true
        }
        
    }
    
    //função que adiciona as frutas no lado esquerdo da balança e trava quando o valor do lado direito for igual o do peso
    func addLeftFruit(fruit: FruitEnum){
        if !(DataModel.shared.weightLeftSide == DataModel.shared.weight){
            DataModel.shared.weightLeftSide += fruit.valor
            print("peso na esquerda: \(DataModel.shared.weightLeftSide)")
        }
        else{
            DataModel.shared.leftBalanceLocked = true
        }
        
    }
    
    func removeRightFruit(fruit: FruitEnum){
        if !(DataModel.shared.weightRightSide == DataModel.shared.weight){
            DataModel.shared.weightRightSide -= fruit.valor
            print("peso na direita: \(DataModel.shared.weightRightSide)")
        }
        else{
            DataModel.shared.rightBalanceLocked = true
        }
    }
    
    func removeLeftFruit(fruit: FruitEnum){
        if !(DataModel.shared.weightLeftSide == DataModel.shared.weight){
            DataModel.shared.weightLeftSide -= fruit.valor
            print("peso na esquerda: \(DataModel.shared.weightLeftSide)")
        }
        else{
            DataModel.shared.leftBalanceLocked = true
        }
    }
}
