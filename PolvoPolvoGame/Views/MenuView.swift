//
//  MenuView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 29/01/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            VStack{
            
                Text("Nome do Jogo")
                    .font(Font.custom("Istok Web", size: 50))
                    .bold()
                Text("Sua Melhor Pontuação")
                    .font(Font.custom("Istok Web", size: 23))
                    .bold()
                Text("\(DataModel.shared.contadorEquacoes)")
                    .font(Font.custom("Istok Web", size: 36))
                
                Image("Polvo")
                
                Button {
                    print("Indo pro Jogo")
                    
                } label: {
                    ZStack{
                        Image("ButtonMenu")
                        Text("Jogar")
                            .font(Font.custom("Istok Web", size: 27))
                            .bold()
                    }
                }
                .padding(.all, 0)
                
                Button {
                    print("Indo por Tutorial")
                    
                } label: {
                    ZStack{
                        Image("ButtonMenu")
                        Text("Tutorial")
                            .font(Font.custom("Istok Web", size: 27))
                            .bold()
                    }
                }
                .padding(.all, 0)
                
            }
            .background(
                Image("Back")
                    .ignoresSafeArea()
            )
            .foregroundStyle(Color(.white))
            .toolbar {
                ToolbarItem (placement: .automatic) {
                    Button {
                        print("menu")
                        DataModel.shared.soundIsOn.toggle()
                    } label: {
                        if DataModel.shared.soundIsOn{
                            Image("SoundButton")
                        }
                        else {
                            Image("SoundOffButton")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
