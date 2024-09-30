//
//  CharacterView.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import SwiftUI


struct CharacterView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @Environment(\.presentationMode) var presentationMode
    let id: String

    var body: some View {
        VStack {
            CharactersTopBar(
                title: "# \(viewModel.state.fighterNumber)  \(viewModel.state.name)",
                showBackButton: true,
                onClickBackButton: {
                    presentationMode.wrappedValue.dismiss()
                },
                logo: viewModel.state.seriesImage
            )
            
            ContentCharacterView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.getCharacterByNumber(id: id)
        }
        .onDisappear {
            viewModel.cleanScreen()
        }
    }
}

import SwiftUI

struct ContentCharacterView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @State private var cardOffsetY: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color.customBlack.ignoresSafeArea()
            
            if viewModel.isLoadingCharacter {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
                    Spacer().frame(height: 16)
                    
                    Text("Cargando...")
                        .foregroundColor(.white)
                    Text("Por favor espera mientras se carga el personaje.")
                        .foregroundColor(.white)
                }
                .transition(.opacity)
            } else {
                VStack {
                    CharacterImage(imageUrl: viewModel.state.fullImage)
                    
                    Spacer().frame(height: 10)
                    
                    CardView(
                        text: viewModel.state.description,
                        offsetY: $cardOffsetY
                    )
                    .animation(.easeOut(duration: 1), value: cardOffsetY)
                    .onAppear {
                        cardOffsetY = 0
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let text: String
    @Binding var offsetY: CGFloat
    
    var body: some View {
        ScrollView {
            Text(text)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .offset(y: offsetY) 
                .padding([.leading, .trailing], 15)
        }
    }
}
