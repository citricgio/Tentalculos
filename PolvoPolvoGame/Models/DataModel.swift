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
    
    var valor_variavel: Int = 0
}


