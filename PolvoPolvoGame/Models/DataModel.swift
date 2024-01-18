//
//  DataModel.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

@Observable class DataModel{
    static let shared = DataModel()
    var peso: Int = 0
    
    var contador: Int = 0
    
    //Variáveis que fazem parte da 
    var valor_variavel: Int = 0
    
    //Variáveis que são criadas pela balancaDados e usadas na calculadora
    var peso_direita: Int = 0
    var peso_esquerda: Int = 0
}


