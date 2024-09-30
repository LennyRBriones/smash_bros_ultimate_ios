//
//  Data Model.swift
//  Smash Characters
//
//  Created by Lenny R. Briones on 29/09/24.
//

import Foundation

struct SingleCharacterModel: Codable {
    let name: String
    let series: Series
    let fighterNumber: String
    let images: Images
    let dlcCharacter: Bool
    let description: String
    let otherAppearances: [String]?
}

struct Series: Codable {
    let name: String
    let image: String
}

struct Images: Codable {
    let bannerImage: String
    let fullImage: String
}

struct CharactersModel: Codable {
    let name: String
    let fighterNumber: String
    let images: CharacterImages
    let series: SeriesData
}

struct CharacterImages: Codable {
    let bannerImage: String
    let fullImage: String
}

struct SeriesData: Codable {
    let name: String
    let image: String
}

struct CharacterState {
    var name: String = ""
    var seriesName: String = ""
    var seriesImage: String = ""
    var fighterNumber: String = ""
    var bannerImage: String = ""
    var fullImage: String = ""
    var dlcCharacter: Bool = false
    var description: String = ""
    var otherAppearances: [String] = []
}
