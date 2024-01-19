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
    
    //Booleanos usados pela balancaDados para travar a equação
    var balanca_esquerda_travada: Bool = false
    var balanca_direita_travada: Bool = false
    
    //Valor em que o usuário vai múltiplicar ou dividir
    var contador: Int = 0
    
    //Numero de equações feitas na fase
    var contadorEquacoes: Int = 0
}


