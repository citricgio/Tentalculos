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
    var peso: Int = 0 //valor de cada lado da equação
    var valorX: Int = 0 //variável ou o X da equação
    var valorMultiplicador: Int = 0 //valor que múltiplica a variável ou o X
    var b: Int = 0 //valor que soma o lado esquerdo com o X para ser igual ao peso
    var c: Int = 0 //valor que soma o lado direito com o X para ser igual ao peso ou o Peso se não houver X do lado direito
    
    //variáveis contam as frutas de cada lado quando o usuário estiver montando a balança
    var peso_lado_esquerdo: Int = 0
    var peso_lado_direito: Int = 0
    //String que contém a equação
    var textoEquacao: String = "" 
    
    //Booleanos usados pela balancaDados para travar a equação
    var balanca_esquerda_travada: Bool = false
    var balanca_direita_travada: Bool = false
    
    //Valor em que o usuário vai múltiplicar ou dividir e é gerado pelo RemoverNumeros
    var contador: Int = 0
    
    //Numero de equações feitas na fase
    var contadorEquacoes: Int = 0
}


