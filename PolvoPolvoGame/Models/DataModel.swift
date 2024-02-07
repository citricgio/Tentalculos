//
//  DataModel.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import Foundation
import SwiftUI

//classe em que se guarda as variáveis que precisam ser compartilhadas entre as files
@Observable class DataModel{
    static let shared = DataModel()
    
    //valores gerados pelo GeradorPesos
    var weight: Int = 7 //valor de cada lado da equação
    var valueX: Int = 0 //variável ou o X da equação
    var valueMultiplier: Int = 0 //valor que múltiplica a variável ou o X
    var b: Int = 0 //valor que soma o lado esquerdo com o X para ser igual ao peso
    var c: Int = 0 //valor que soma o lado direito com o X para ser igual ao peso ou o Peso se não houver X do lado direito
    
    //variáveis contam as frutas de cada lado quando o usuário estiver montando a balança
    var weightLeftSide: Int = 0
    var weightRightSide: Int = 0
    
    //String que contém a equação
    var equationText: String = "" 
    
    //Booleanos usados pela balancaDados para travar a equação
    var leftBalanceLocked: Bool = false
    var rightBalanceLocked: Bool = false
    
    // variável que indica se tem X na bandeja ou não
    var hasX: Bool = false
    
    //Valor em que o usuário vai múltiplicar ou dividir e é gerado pelo RemoverNumeros
//    var contador: Int = 0
    var numbersButton: FruitEnum = .fruit1
//    var indexNumeros: Int = 1
    
    //Numero de equações feitas na fase
    var equationCount: Int = 0
    
    //Variável que vai falar se o som está Ativo ou não
    var soundIsOn: Bool = true
    
    //Melhor score do numedo de equacoes
    var bestPoints: Int = 0
    var bestPointsLabel: String = ""
}


