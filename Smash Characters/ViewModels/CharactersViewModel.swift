//
//  CharactersViewModel.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import Combine
import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [CharactersModel] = []
    @Published var state = CharacterState()
    @Published var isLoading = false
    @Published var isLoadingCharacter = false
    
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository = CharactersRepository()) {
        self.repository = repository
        fetchCharacters()
    }
    
    func fetchCharacters() {
        isLoading = true
        Task {
            do {
                let response = try await repository.getCharacters()
                let sortedCharacters = response.sorted { char1, char2 in
                    char1.fighterNumber.extractNumber() < char2.fighterNumber.extractNumber()
                }
                
                DispatchQueue.main.async {
                    self.characters = sortedCharacters
                    self.isLoading = false
                }
            } catch {
                print("Error al obtener personajes: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    func getCharacterByNumber(id: String) {
        isLoadingCharacter = true
        Task {
            do {
                let response = try await repository.getCharacterByNumber(id: id)
                
                DispatchQueue.main.async {
                    self.state = CharacterState(
                        name: response?.name ?? "",
                        seriesName: response?.series.name ?? "",
                        seriesImage: response?.series.image ?? "",
                        fighterNumber: response?.fighterNumber ?? "",
                        bannerImage: response?.images.bannerImage ?? "",
                        fullImage: response?.images.fullImage ?? "",
                        dlcCharacter: response?.dlcCharacter ?? false,
                        description: response?.description ?? "",
                        otherAppearances: response?.otherAppearances ?? []
                    )
                    self.isLoadingCharacter = false
                }
            } catch {
                print("Error al obtener personaje: \(error)")
                DispatchQueue.main.async {
                    self.isLoadingCharacter = false
                }
            }
        }
    }
    
    func cleanScreen() {
        DispatchQueue.main.async {
            self.state = CharacterState()
        }
    }
}

extension String {
    func extractNumber() -> Int {
        let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        return number ?? Int.max
    }
}
