//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var myLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display(for pokemon: PokemonSpecy) {
        let id = pokemon.url.split(separator: "/")[5]
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        myImg.image = UIImage(named: "pokedex") //UIImage(url: URL(string: url))
        myLbl.text = pokemon.name
        myLbl.font = UIFont(name: "Arial", size: 15)
    }

}
