//
// ContentView.swift
// PolvoPolvoGame
//
// Created by Thiago Liporace on 15/01/24.
//
import SwiftUI
import SpriteKit

struct ContentView: View {
     

    
  var scene: MenuScene {
    let scene: MenuScene = MenuScene()
    scene.scaleMode = .resizeFill
    return scene
      
  }
   
    var body: some View {
        if DataModel.shared.tutorial {
            TutorialView()
        } else {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .statusBarHidden(true)
        }
    }
}
#Preview {
  ContentView() 
}









