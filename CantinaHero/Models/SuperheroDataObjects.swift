//
//  SuperheroDataObjects.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import Foundation

// MARK: - SuperHero
struct SuperHero: Codable {
    let response, resultsFor: String
    let results: [HeroData]

    enum CodingKeys: String, CodingKey {
        case response
        case resultsFor = "results-for"
        case results
    }
}

// MARK: - HeroData
struct HeroData: Codable {
    let id, name: String
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let image: HeroImage
}

// MARK: - Appearance
struct Appearance: Codable {
    let gender, race: String
    let height, weight: [String]
    let eyeColor, hairColor: String

    enum CodingKeys: String, CodingKey {
        case gender, race, height, weight
        case eyeColor = "eye-color"
        case hairColor = "hair-color"
    }
}

// MARK: - Biography
struct Biography: Codable {
    let fullName, alterEgos: String
    let aliases: [String]
    let placeOfBirth, firstAppearance, publisher, alignment: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case aliases
        case placeOfBirth = "place-of-birth"
        case firstAppearance = "first-appearance"
        case publisher, alignment
    }
}

// MARK: - Connections
struct Connections: Codable {
    let groupAffiliation, relatives: String

    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "group-affiliation"
        case relatives
    }
}

// MARK: - HeroImage
struct HeroImage: Codable {
    let url: String
}

// MARK: - Powerstats
struct Powerstats: Codable {
    let intelligence, strength, speed, durability, power, combat: String
}

// MARK: - Work
struct Work: Codable {
    let occupation, base: String
}

