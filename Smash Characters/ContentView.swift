//
//  ContentView.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharactersViewModel() 

    var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
