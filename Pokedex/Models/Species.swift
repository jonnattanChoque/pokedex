//
//  Species.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

struct Specie: Codable {
    let baseHappiness, captureRate: Int
    let color: Color
    let eggGroups: [Color]
    let evolutionChain: EvolutionChain
    let flavorTextEntries: [FlavorTextEntry]
    let formsSwitchable: Bool
    let genderRate: Int
    let generation, habitat: Color
    let hasGenderDifferences: Bool
    let hatchCounter, id: Int
    let isBaby, isLegendary, isMythical: Bool
    let name: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
        case formsSwitchable = "forms_switchable"
        case genderRate = "gender_rate"
        case generation, habitat
        case hasGenderDifferences = "has_gender_differences"
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case name, order
    }
}

// MARK: - Color
struct Color: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, version: Color

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
