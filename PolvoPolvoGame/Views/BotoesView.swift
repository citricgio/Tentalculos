//
//  BotoesView.swift
//  PolvoPolvoGame
//
//  Created by Giovanna Bonifacho on 22/01/24.
//

import SwiftUI

struct BotoesView: View {
    
    var numeros: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var operacoes: [String] = ["-", ":"]
    @State var indexNumero: Int = 0
    @State var indexOperacao: Int = 0
    
    var removerNumeros = RemoverNumeros()
    
    
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    removerNumeros.AumentarContador()
                }, label: {
                    if DataModel.shared.contador == DataModel.shared.peso {
                        
                    }
                    else {
                        Image("setacima")
                    }
                    
                })
                ZStack {
                    Image("box")
                    Text("\(DataModel.shared.contador)")
                }
                
                Button(action: {
                    removerNumeros.DiminuirContador()
                }, label: {
                    if DataModel.shared.contador == 0 {
                        
                    }
                    else {
                        Image("setabaixa")
                    }
                })
                
                

            }
        
        }
        
    }
}

#Preview {
    BotoesView()
}
