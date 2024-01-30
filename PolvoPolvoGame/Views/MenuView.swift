//
//  MenuView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 29/01/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    print("menu")
                } label: {
                    Image("SoundButton")
                        .padding(.trailing, 20)
                        .padding(.vertical, 0)
                }
            }.padding(.vertical,0)
            Text("Nome do Jogo")
               
                .fontWeight(.bold)
            Text("Sua Melhor Pontuação")
                
            Text("\(DataModel.shared.contadorEquacoes)")
                
            Image("Polvo")
            Button {
                print("funcionando")
            } label: {
                ZStack{
                    Image("ButtonMenu")
                    Text("Tutorial")
                        

                }
            }.padding(.all, 0)
            Button {
                print("funcionando")
            } label: {
                ZStack{
                    Image("ButtonMenu")
                    Text("Tutorial")
                        

                }
            }.padding(.all, 0)
        }
        .background(
            Image("Back")
                .ignoresSafeArea()
        )
        .foregroundStyle(Color(.white))
    }
}

#Preview {
    MenuView()
}
