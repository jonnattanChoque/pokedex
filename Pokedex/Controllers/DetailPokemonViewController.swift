//
//  DetailPokemonViewController.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class DetailPokemonViewController: UIViewController, ReloadViewDelegate {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var frontImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typesTitleLbl: UILabel!
    @IBOutlet weak var typesLbl: UILabel!
    @IBOutlet weak var habitatLbl: UILabel!
    
    var id = 0
    var name = ""
    var specie: Specie?
    var pokemon: myPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInfo()
        
        self.title = name
    }
    
    func loadInfo(){
        PokemonModelNetwork.shared.delegate = self
        PokemonModelNetwork.shared.detail(id: id)
    }
    
    func showInfo(){
        nameLbl.text = specie?.name
        self.view.backgroundColor = UIColor(name: specie!.color.name)
        nameLbl.textColor = UIColor.black
        
        habitatLbl.text = "Habitat: \(String(describing: specie!.habitat.name))"
        
        let urlBack = pokemon?.sprites.backDefault
        let urlFront = pokemon?.sprites.frontDefault
        backImg.image = UIImage(url: URL(string: urlBack!))
        frontImg.image = UIImage(url: URL(string: urlFront!))
        
        typesTitleLbl.text = "Types"
        var fullString = ""
        for type in pokemon!.types{
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(type.type.name)\n"
            
            fullString = fullString + formattedString
        }
        typesLbl.text = fullString
    }
    
    //MARK: Protocols
    func reloadView() {
        if PokemonModelNetwork.shared.pokemon != nil{
            pokemon = PokemonModelNetwork.shared.pokemon
            PokemonModelNetwork.shared.specie(id: id)
            PokemonModelNetwork.shared.pokemon = nil
        }
        if PokemonModelNetwork.shared.specie != nil{
            specie = PokemonModelNetwork.shared.specie
            showInfo()
        }
    }
    
    func errorReload(message: String) {
        print(message)
    }

}
