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
    var fruitList: [FrutaEnum] = [.fruta1, .fruta2, .fruta3, .fruta5]
    //variavel que armazena a fruta selecionada no momento
    var selectedFruit: FrutaEnum = .fruta1
    //booleano que troca o valor para variar entre subtracao e divisao
    var operationBool: Bool = true
    //variavel que armazena a operacao selecionada no momento
    var selectedOperation: OperacoesEnum = .subtracao
    
    //vai mudar o numero do botao, na ordem: 1, 2, 3 ou 5
    func changeNumber() -> FrutaEnum {
        //
        if (DataModel.shared.numerosBotao.valor < DataModel.shared.peso){
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
        print(DataModel.shared.numerosBotao.valor)
        return selectedFruit
    }
    
    // vai mudar a operação do botao, sendo subtracao ou divisao
    func changeOperation() -> OperacoesEnum {
        // ao acinar a funcao, o operationBool varia entre true ou false
        operationBool.toggle()
        // se o operationBool estiver no true, a selectedOperation será subtracao, se estiver no false, sera divisao
        if operationBool {
            selectedOperation = OperacoesEnum.subtracao
            return selectedOperation
        } else {
            selectedOperation = OperacoesEnum.divisao
            return selectedOperation
        }
    }
    //teste
        
    
}
