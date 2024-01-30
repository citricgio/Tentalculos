//
//  EndView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 29/01/24.
//

import SwiftUI

struct EndView: View {
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
            
            Text("Ops!")
            Text("você deixou os pratos cairem.")
            
            HStack{
                
            }
            ZStack{
                
            }
            Button {
                
            } label: {
                ZStack{
                    Text("reiniciar")
                }
            }
        }
        .background(
            Image("Back")
                .ignoresSafeArea()
        )
        .foregroundStyle(Color(.white))
    }
}

#Preview {
    EndView()
}
