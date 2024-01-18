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
    
    //valores gerados pelo GeradorPesos
    var peso: Int = 0
    var valorX: Int = 0
    var valorMultiplicador: Int = 0
    var b: Int = 0
    var c: Int = 0
    
    //valores usados pela balancaDados
    var peso_direita: Int = 0
    var peso_esquerda: Int = 0
    
    //Valor em que o usuário vai múltiplicar ou dividir
    var contador: Int = 0
    
    //Numero de equações feitas na fase
    var contadorEquacoes: Int = 0
}


