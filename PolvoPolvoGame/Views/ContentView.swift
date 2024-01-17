//
//  ContentView.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 15/01/24.
//

import SwiftUI

struct ContentView: View {
    
    var removerNumeros = RemoverNumeros()
    
    var gerador = GeradorPesos()
    
    var body: some View {
        VStack {
            BotoesRemoverNumero(removerNumeros: removerNumeros,gerador: gerador)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
