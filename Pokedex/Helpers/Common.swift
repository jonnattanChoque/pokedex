//
//  Common.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

struct Common {
    //URL de losrequest
    struct APIRest{
        
        static let URL_API = "https://pokeapi.co/api/v2/"
    }
    
    struct Notifications{
        struct Pokemon{
            static let searchNotificationSuccess : String = "Pokedex.Pokemon.search.success";
            static let searchNotificationError : String = "Pokedex.Pokemon.search.error";
            
            static let detailNotificationSuccess : String = "Pokedex.Pokemon.detail.success";
            static let detailNotificationError : String = "Pokedex.Pokemon.detail.error";
            
            static let specieNotificationSuccess : String = "Pokedex.Pokemon.specie.success";
            static let specieNotificationError : String = "Pokedex.Pokemon.specie.error";
        }
        struct Generation{
            static let searchNotificationSuccess : String = "Pokedex.Generation.search.success";
            static let searchNotificationError : String = "Pokedex.Generation.search.error";
            
            static let detailNotificationSuccess : String = "Pokedex.Generation.detail.success";
            static let detailNotificationError : String = "Pokedex.Generation.detail.error";
        }
        struct Item{
            static let searchNotificationSuccess : String = "Pokedex.Item.search.success";
            static let searchNotificationError : String = "Pokedex.Item.search.error";
        }
    }
}
