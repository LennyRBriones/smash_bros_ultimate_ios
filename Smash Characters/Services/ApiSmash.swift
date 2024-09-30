//
//  ApiSmash.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import Foundation

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    func getCharacters() async throws -> [CharactersModel] {
        guard let url = URL(string: "\(Constants.baseURL)api/characters") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let characters = try JSONDecoder().decode([CharactersModel].self, from: data)
        return characters
    }

    func getCharacterByNumber(id: String) async throws -> SingleCharacterModel {
        guard let url = URL(string: "\(Constants.baseURL)api/characters/\(id)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let character = try JSONDecoder().decode(SingleCharacterModel.self, from: data)
        return character
    }
}
