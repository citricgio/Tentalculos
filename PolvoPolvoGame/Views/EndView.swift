//
//  EndView.swift
//  PolvoPolvoGame
//
//  Created by Gabriel Sabaini on 29/01/24.
//
//
//import SwiftUI
//
//struct EndView: View {
//    
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        NavigationView {
//            
//            VStack{
//                
//                Text("Ops!")
//                    .font(Font.custom("Istok Web", size: 35))
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                Text("você deixou os pratos cairem.")
//                    .font(Font.custom("Istok Web", size: 23))
//                
//                HStack{
//                    Image("PratoQuebrado")
//                    Image("PratoQuebrado")
//                    Image("PratoQuebrado")
//                }
//                ZStack{
//                    Image("SquareBox")
//                        .frame(width: 360.98, height: 355.94)
//
//                    VStack {
//                        Text("Pontuação")
//                            .font(Font.custom("Istok Web", size: 23))
//                            .bold()
//                        Text("\(DataModel.shared.contadorEquacoes)")
//                            .font(Font.custom("Istok Web", size: 36))
//                        Text("Sua melhor pontuação")
//                            .font(Font.custom("Istok Web", size: 23))
//                            .fontWeight(.bold)
//                        Text("73")
//                            .font(Font.custom("Istok Web", size: 36))
//                    }
//                }
//                
//                Button {
//                    
//                    print("Reiniciando")
//                    
//                } label: {
//                    ZStack{
//                        Image("ButtonMenu")
//                        Text("Reiniciar")
//                            .font(Font.custom("Istok Web", size: 27))
//                            .bold()
//                    }
//                    
//                    .frame(width: 170, height: 55)
//                }
//
//                .padding(.all, 0)
//                
//                Button {
//                    print("Indo para o Menu")
//                        dismiss()
//         //           dismiss()
//                } label: {
//                    ZStack{
//                        Image("ButtonMenu")
//                        Text("Menu")
//                            .font(Font.custom("Istok Web", size: 27))
//                            .bold()
//                    }
//                    .frame(width: 170, height: 55)
//                }
//                .padding(.all, 0)
//            }
//            .background(
//                Image("Back")
//                    .ignoresSafeArea()
//            )
//            .foregroundStyle(Color(.white))
//            .toolbar {
//                ToolbarItem (placement: .automatic) {
//                    Button {
//                        DataModel.shared.soundIsOn.toggle()
//                        if DataModel.shared.soundIsOn{
//                            print("Som ligado")
//                        }
//                        else {
//                            print("Som desligado")
//                        }
//                    } label: {
//                        if DataModel.shared.soundIsOn{
//                            Image("SoundButton")
//                        }
//                        else {
//                            Image("SoundOffButton")
//                        }
//                    }                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    EndView()
//}
