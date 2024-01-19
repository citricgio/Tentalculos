//
// ContentView.swift
// PolvoPolvoGame
//
// Created by Thiago Liporace on 15/01/24.
//
import SwiftUI
import SpriteKit

struct ContentView: View {
    
  var scene: GameScene {
    let scene: GameScene = GameScene()
    scene.scaleMode = .resizeFill
    return scene
  }
    
  var body: some View {
      
    SpriteView(scene: scene)
      .ignoresSafeArea()
  }
}
#Preview {
  ContentView()
}









