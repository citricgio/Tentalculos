//
//  Calculadora.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

class Calculadora {
    
    func Subtracao(){
        if (DataModel.shared.peso - DataModel.shared.contador >= 0){
            DataModel.shared.peso -= DataModel.shared.contador
        }
        print(DataModel.shared.peso)
    }
    
    func Divisao(){
        if (DataModel.shared.peso / DataModel.shared.contador >= 0) {
            DataModel.shared.peso = DataModel.shared.peso / DataModel.shared.contador
        }
        print(DataModel.shared.peso)
    }
    
}
