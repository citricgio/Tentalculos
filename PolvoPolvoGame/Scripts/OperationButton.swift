//
//  RemoverNumeros.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

//Escolher a operacao e o numero para realizar os cálculos na balança
@Observable class OperationButton {
    
    //variavel usada para passar pela fruitList
    var fruitIndex = 0
    //lista que contém todos os valores possiveis do botao
    var fruitList: [FruitEnum] = [.fruit1, .fruit2, .fruit3, .fruit5]
    //variavel que armazena a fruta selecionada no momento
    var selectedFruit: FruitEnum = .fruit1
    //booleano que troca o valor para variar entre subtracao e divisao
    var operationBool: Bool = true
    //variavel que armazena a operacao selecionada no momento
    var selectedOperation: OperationsEnum = .subtraction
    
    //vai mudar o numero do botao, na ordem: 1, 2, 3 ou 5
    func changeNumber() -> FruitEnum {
        //
        if (DataModel.shared.numbersButton.valor < DataModel.shared.weight){
            // ao acionar essa função ela irá aumentar 1 no fruitIndex até o fruitIndex ser menor que 3, quando ele se tornar 3, volta para o 0
                if fruitIndex < 3 {
                    fruitIndex += 1
                } else {
                    fruitIndex = 0
                }
            // a selectedFruit será a posição da lista de acordo com o fruitIndex
            selectedFruit = fruitList[fruitIndex]
                return selectedFruit
//            }
        }
        print(DataModel.shared.numbersButton.valor)
        return selectedFruit
    }
    
    // vai mudar a operação do botao, sendo subtracao ou divisao
    func changeOperation() -> OperationsEnum {
        // ao acinar a funcao, o operationBool varia entre true ou false
        operationBool.toggle()
        // se o operationBool estiver no true, a selectedOperation será subtracao, se estiver no false, sera divisao
        if operationBool {
            selectedOperation = OperationsEnum.subtraction
            return selectedOperation
        } else {
            selectedOperation = OperationsEnum.division
            return selectedOperation
        }
    }
}
