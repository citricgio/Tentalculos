//
//  RemoverNumeros.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

//Colocar o número para ser feito os cálculos na balança
@Observable class OperationButton {
    
    var fruitIndex = 0
    var fruitList: [FrutaEnum] = [.fruta1, .fruta2, .fruta3, .fruta5]
    var selectedFruit: FrutaEnum = .fruta1
    var operationBool: Bool = true
    var selectedOperation: OperacoesEnum = .subtracao
    
    //vai aumentar o numero do contador
    func changeNumber() -> FrutaEnum {
        // verifica se o peso da balança é menor do que
        if (DataModel.shared.numerosBotao.valor < DataModel.shared.peso){
                if fruitIndex < 3 {
                    fruitIndex += 1
                } else {
                    fruitIndex = 0
                }
            selectedFruit = fruitList[fruitIndex]
                return selectedFruit
//            }
        }
        print(DataModel.shared.numerosBotao.valor)
        return selectedFruit
    }
    
    func changeOperation() -> OperacoesEnum {
        operationBool.toggle()
        if operationBool {
            selectedOperation = OperacoesEnum.subtracao
            return selectedOperation
        } else {
            selectedOperation = OperacoesEnum.divisao
            return selectedOperation
        }
    }
    
        
    
}
