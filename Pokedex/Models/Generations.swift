//
//  Generations.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

struct Generation: Decodable {
    let name: String
    let url: String
  
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Generations: Decodable {
    let count: Int
    let all: [Generation]
  
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}

struct GenerationDetail: Codable {
    let abilities: [Ability]
    let id: Int
    let mainRegion: MainRegion
    let moves: [MainRegion]
    let name: String
    let names: [Name]
    var pokemonSpecies: [PokemonSpecy]
    let types, versionGroups: [MainRegion]

    enum CodingKeys: String, CodingKey {
        case abilities, id
        case mainRegion = "main_region"
        case moves, name, names
        case pokemonSpecies = "pokemon_species"
        case types
        case versionGroups = "version_groups"
    }
}

// MARK: - MainRegion
struct MainRegion: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct Name: Codable {
    let language: MainRegion
    let name: String
}

// MARK: - PokemonSpecy
struct PokemonSpecy: Codable {
    let name: String
    let url: String
    var image: String? = ""
}
