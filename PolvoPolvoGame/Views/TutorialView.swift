//
//  TutorialView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 15/02/24.
//

import SwiftUI

struct TutorialView: View {
    
    var tutorial: [String] = ["tutorial1","tutorial2","tutorial3","tutorial4","tutorial5","tutorial6","tutorial7","tutorial8","tutorial9","tutorial10","tutorial11","tutorial12","tutorial13","tutorial14","tutorial15","tutorial16","tutorial17","tutorial18","tutorial19","tutorial20","tutorial21","tutorial22","tutorial23","tutorial24","tutorial25",]
    
    var body: some View {
        
        Image(tutorial[0])
            .resizable()
            .scaledToFill()
            .padding(.bottom, 25)
    }
}

#Preview {
    TutorialView()
}
