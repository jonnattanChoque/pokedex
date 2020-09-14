//
//  PokemonNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class PokemonNetwork{
    func search(offset: Int){
        ApiRequest.sharedInstance.getData(dec: Pokemons.self, endpoint: "pokemon/?limit=50&offset=\(offset)") { (data) in
            let result:[String: Pokemons] = ["result": data as! Pokemons];
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Pokemon.searchNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
    
    func detail(id: Int){
        ApiRequest.sharedInstance.getData(dec: myPokemon.self, endpoint: "pokemon/\(id)") { (data) in
            let myPokemon = data as! myPokemon
            
            let result:[String: myPokemon] = ["result": myPokemon];
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Pokemon.detailNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
    
    func specie(id: Int){
        ApiRequest.sharedInstance.getData(dec: Specie.self, endpoint: "pokemon-species/\(id)") { (data) in
            let specie = data as! Specie
            
            let result:[String: Specie] = ["result": specie];
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Pokemon.specieNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
}
