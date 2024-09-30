//
//  BodyComponents.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//
import SwiftUI

struct MainTopBar: View {
    let title: String
    let showBackButton: Bool
    let onClickBackButton: () -> Void
    let onClickAction: () -> Void
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onClickBackButton()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            if !showBackButton {
                Button(action: {
                    onClickAction()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(Color.black)
    }
}

struct CharactersTopBar: View {
    let title: String
    let showBackButton: Bool
    let onClickBackButton: () -> Void
    let logo: String
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onClickBackButton()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            if showBackButton {
                AsyncImage(url: URL(string: logo)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
            }
        }
        .padding()
        .background(Color.customBlack)
    }
}

struct CharacterImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
}


import SwiftUI

struct CardCharacter: View {
    let character: CharactersModel
    let onClick: () -> Void
    
    var body: some View {
        ZStack {
            Color.customBlack
                .background(Color.customBlack.opacity(0.5))
                .cornerRadius(8)
                .shadow(radius: 5)
                .onTapGesture {
                    onClick()
                }
            
            MainImage(imageUrl: character.images.bannerImage)
                .frame(height: 130)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(character.fighterNumber)   \(character.name)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                AsyncImage(url: URL(string: character.series.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 40)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    @unknown default:
                        ProgressView()
                    }
                }
            }
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .padding(.horizontal, 1)
        .padding(.vertical, 1)
    }
}

struct MainImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                ProgressView()
            }
        }
        .cornerRadius(8)
    }
}
