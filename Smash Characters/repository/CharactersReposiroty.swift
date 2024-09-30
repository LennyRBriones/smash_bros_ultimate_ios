//
//  CharactersReposiroty.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import Foundation

class CharactersRepository {
    private let apiService: ApiService

    init(apiService: ApiService = ApiService.shared) {
        self.apiService = apiService
    }

    func getCharacters() async throws -> [CharactersModel] {
        let characters = try await apiService.getCharacters()
        return characters
    }

    func getCharacterByNumber(id: String) async throws -> SingleCharacterModel? {
        let character = try await apiService.getCharacterByNumber(id: id)
        return character
    }
}
