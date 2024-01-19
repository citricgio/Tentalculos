//
//  RemoverNumeros.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

//Colocar o número para ser feito os cálculos na balança
class RemoverNumeros {
    
    //vai aumentar o numero do contador
    func AumentarContador(){
        if (DataModel.shared.contador < DataModel.shared.peso){
            DataModel.shared.contador += 1
        }
        print(DataModel.shared.contador)
    }
    
    //vai diminuir o número do contador
    func DiminuirContador(){
        if (DataModel.shared.contador > 0){
            DataModel.shared.contador -= 1
        }
        print(DataModel.shared.contador)
    }
    
    
}
