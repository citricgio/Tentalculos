//
//  BotoesRemoverNumero.swift
//  PolvoPolvoGame
//
//  Created by Thiago Liporace on 17/01/24.
//

import SwiftUI

struct BotoesRemoverNumero: View {
    
    var removerNumeros = RemoverNumeros()
    
    var gerador = GeradorPesos()
    
    var calculadora = Calculadora()
    
    var body: some View {
        HStack{
            
            
            VStack{
                Button(action: {
                    gerador.Gerar_Numeros_Basico()
                }, label: {
                    Text("gerar")
                })
                
                Button(action: {
                    removerNumeros.AumentarContador()
                }, label: {
                    Text("aumentar")
                })
                
                Button(action: {
                    removerNumeros.DiminuirContador()
                }, label: {
                    Text("diminuir")
                })
            }
            
            Button(action: {
                calculadora.Subtracao()
            }, label: {
                Text("subtracao")
            })
            
            Button(action: {
                calculadora.Divisao()
            }, label: {
                Text("divisao")
            })
            
        }
    }
}

#Preview {
    BotoesRemoverNumero()
}
