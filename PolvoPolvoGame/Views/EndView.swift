//
//  EndView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 29/01/24.
//

import SwiftUI

struct EndView: View {
    var body: some View {
        NavigationView {
            
            VStack{
                
                Text("Ops!")
                    .font(Font.custom("Istok Web", size: 35))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("você deixou os pratos cairem.")
                    .font(Font.custom("Istok Web", size: 23))
                
                HStack{
                    Image("PratoQuebrado")
                    Image("PratoQuebrado")
                    Image("PratoQuebrado")
                }
                ZStack{
                    Image("SquareBox")
                    VStack {
                        Text("Pontuação")
                            .font(Font.custom("Istok Web", size: 23))
                            .bold()
                        Text("\(DataModel.shared.contadorEquacoes)")
                            .font(Font.custom("Istok Web", size: 36))
                        Text("Sua melhor pontuação")
                            .font(Font.custom("Istok Web", size: 23))
                            .fontWeight(.bold)
                        Text("73")
                            .font(Font.custom("Istok Web", size: 36))
                    }
                }
                
                //TODO: Arrumar o tamanho do botão
                Button {
                    
                    print("Reiniciando")
                    
                } label: {
                    ZStack{
                        Image("ButtonMenu")
                        Text("Reiniciar")
                            .font(Font.custom("Istok Web", size: 27))
                            .bold()
                    }
                }
                .padding(.all, 0)
                
                //TODO: Arrumar o tamanho do botão
                Button {
                    print("Indo para o Menu")
                    
                } label: {
                    ZStack{
                        Image("ButtonMenu")
                        Text("Menu")
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
    EndView()
}
