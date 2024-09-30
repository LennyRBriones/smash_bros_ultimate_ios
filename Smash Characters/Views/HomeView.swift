//
//  HomeView.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//
import SwiftUI


struct HomeView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        VStack {
            MainTopBar(
                title: "Smash Bros Fighters",
                showBackButton: false,
                onClickBackButton: {},
                onClickAction: {
                }
            )
            
            ContentHomeView(viewModel: viewModel)
        }
    }
}

struct ContentHomeView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        ZStack {
            Color.customBlack.ignoresSafeArea()
            
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
                    Spacer().frame(height: 16)
                    
                    Text("Cargando...")
                        .foregroundColor(.white)
                    Text("Por favor espera mientras se cargan los personajes.")
                        .foregroundColor(.white)
                }
            } else {
                List(viewModel.characters, id: \.fighterNumber) { character in
                    NavigationLink(
                        destination: CharacterView(
                            viewModel: viewModel,
                            id: mapFighterNumber(fighterNumber: character.fighterNumber)
                        )
                    ) {
                        CardCharacter(character: character) {
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}



func mapFighterNumber(fighterNumber: String) -> String {
    return fighterNumber.replacingOccurrences(of: "ᵋ", with: "e")
}
