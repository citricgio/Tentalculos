//
//  TutorialView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 15/02/24.
//

import SwiftUI

struct TutorialView: View {
    
    @State var tutorialImages: [String] = ["tutorial1","tutorial2","tutorial3","tutorial4","tutorial5","tutorial6","tutorial7","tutorial8","tutorial9","tutorial10","tutorial11","tutorial12","tutorial13","tutorial14","tutorial15","tutorial16","tutorial17","tutorial18","tutorial19","tutorial20","tutorial21","tutorial22","tutorial23","tutorial24","tutorial25",]
    
    @State var index: Int = 0
    
    var body: some View {
        ZStack {
            Image(tutorialImages[index])
                .resizable()
                .scaledToFill()
                .padding(.bottom, 25)
            Button(action: {
                if index < 24 {
                    index += 1
                } else if index == 24{
                    DataModel.shared.tutorial.toggle()
                }
            }, label: {
                Image("setacima")
                    .resizable()
                    .frame(width: 60, height: 46)
                    .rotationEffect(.degrees(90))
                
            })
            .offset(x: 176, y: 318)
            if index >= 1 {
                Button(action: {
                    if index < 24 {
                        index -= 1
                    }
                }, label: {
                    Image("setacima")
                        .resizable()
                        .frame(width: 60, height: 46)
                        .rotationEffect(.degrees(270))
                })
                .offset(x: -176, y: 318)
                
            }
        }
    }
}

#Preview {
    TutorialView()
}
