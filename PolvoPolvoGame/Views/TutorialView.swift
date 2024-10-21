//
//  TutorialView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 15/02/24.
//

import SwiftUI

struct TutorialView: View {
    
    @State var tutorialImages: [String] = ["tutorial1","tutorial2","tutorial3","tutorial4","tutorial5","tutorial6","tutorial7","tutorial8","tutorial9","tutorial10","tutorial11","tutorial12","tutorial13","tutorial14","tutorial15","tutorial16","tutorial17","tutorial18","tutorial19","tutorial20"]
    
    @State var index: Int = 0
    
    var body: some View {
        ZStack {
            Image(tutorialImages[index])
                .resizable()
                .scaledToFill()
                .padding(.bottom, 25)
            Button(action: {
                if index < 19 {
                    index += 1
                } else if index == 19{
                    DataModel.shared.tutorial.toggle()
                }
            }, label: {
                Image("seta-direita")
                    .resizable()
                    .frame(width: 43, height: 60)
                
            })
            .offset(x: 175, y: (index >= 7 && index <= 12) ? 370 : (index == 13 || index == 14) ? 280 : index >= 14 ? 130 : 318)
            if index >= 1 {
                Button(action: {
                    if index < 24 {
                        index -= 1
                    }
                }, label: {
                    Image("seta-esquerda")
                        .resizable()
                        .frame(width: 43, height: 60)
                })
                .offset(x: -175, y: (index >= 7 && index <= 12) ? 370 : (index == 13 || index == 14) ? 280 : index >= 14 ? 130 : 318)
                
            }
        }
    }
}

#Preview {
    TutorialView()
}
