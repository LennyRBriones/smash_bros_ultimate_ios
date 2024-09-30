//
//  SearchView.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import SwiftUI


struct SearchCharacterView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var query: String = ""
    
    var body: some View {
        ZStack {
            Color.customBlack.ignoresSafeArea()
            
            VStack {
                SearchBar(query: $query) {
                }
                .padding(.horizontal, 16)
                
                if query != "" {
                    let filteredCharacters = viewModel.characters.filter {
                        $0.name.lowercased().contains(query.lowercased())
                    }
                    
                    List(filteredCharacters, id: \.fighterNumber) { character in
                        NavigationLink(
                            destination: CharacterView(
                                viewModel: viewModel,
                                id: mapFighterNumber(fighterNumber: character.fighterNumber)
                            )
                        ) {
                            CharacterRow(character: character) {
                                print("Personaje seleccionado: \(character.name)")
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var query: String
    let onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Buscar personaje...", text: $query)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .onSubmit { onSearch() }
            
            Button(action: {
                query = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CharacterRow: View {
    let character: CharactersModel
    let onClick: () -> Void
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: character.series.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .padding(.trailing, 10)
            
            Text("\(character.fighterNumber)   \(character.name)")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            onClick()
        }
    }
}
