//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(for pokemon: Pokemon) {
        let id = pokemon.url.split(separator: "/")[5]
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        pokemonImg.image = UIImage(named: "pokedex") //UIImage(url: URL(string: url))
        nameLbl.text = pokemon.name
    }
}
