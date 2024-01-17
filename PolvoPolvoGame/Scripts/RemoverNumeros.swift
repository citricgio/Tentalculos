//
//  RemoverNumeros.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

class RemoverNumeros {
    
    func AumentarContador(){
        if (DataModel.shared.contador < DataModel.shared.peso){
            DataModel.shared.contador += 1
        }
        print(DataModel.shared.contador)
    }
    
    func DiminuirContador(){
        if (DataModel.shared.contador > 0){
            DataModel.shared.contador -= 1
        }
        print(DataModel.shared.contador)
    }
    
    
}
