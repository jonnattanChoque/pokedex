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
    @IBOutlet weak var segmented: UISegmentedControl!
    
    @IBOutlet weak var abilitiesView: UIView!
    @IBOutlet weak var abilitiesLbl: UILabel!
    
    @IBOutlet weak var moviesView: UIView!
    @IBOutlet weak var movesCV: UICollectionView!
   
    
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var hpPV: UIProgressView!
    @IBOutlet weak var attackPV: UIProgressView!
    @IBOutlet weak var defensePV: UIProgressView!
    @IBOutlet weak var saPV: UIProgressView!
    @IBOutlet weak var sdPV: UIProgressView!
    @IBOutlet weak var speedPV: UIProgressView!
    
    var id = 0
    var name = ""
    var specie: Specie?
    var pokemon: myPokemon?
    var loader: Loading?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = Loading(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50, y: 100, width: 100, height: 100), image: UIImage(named: "pokedex")!)
        view.addSubview(loader!)
        
        self.title = name
        
        movesCV.delegate = self
        movesCV.dataSource = self
        loadInfo()
    }
    
    func loadInfo(){
        segmented.isHidden = true
        moviesView.isHidden = true
        statsView.isHidden = true
        loader?.startAnimating()
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
        
        
        
        //Stats
        hpPV.progress = Float.init(pokemon!.stats[0].baseStat) / Float(100)
        attackPV.progress = Float.init(pokemon!.stats[1].baseStat) / Float(100)
        defensePV.progress = Float.init(pokemon!.stats[2].baseStat) / Float(100)
        saPV.progress = Float.init(pokemon!.stats[3].baseStat) / Float(100)
        sdPV.progress = Float.init(pokemon!.stats[4].baseStat) / Float(100)
        speedPV.progress = Float.init(pokemon!.stats[5].baseStat) / Float(100)
        
        //Moves
        movesCV.reloadData()
        segmented.isHidden = false
        loader?.stopAnimating()
        
        //Abilities
        var abilitiesString = ""
        for type in pokemon!.abilities{
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(type.ability.name)\n"
            
            abilitiesString = abilitiesString + formattedString
        }
        abilitiesLbl.text = abilitiesString
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

    @IBAction func itemsPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            abilitiesView.isHidden = false
            moviesView.isHidden = true
            statsView.isHidden = true
        case 1:
            moviesView.isHidden = false
            abilitiesView.isHidden = true
            statsView.isHidden = true
        case 2:
            abilitiesView.isHidden = true
            moviesView.isHidden = true
            statsView.isHidden = false
        default:
            abilitiesView.isHidden = false
            moviesView.isHidden = true
            statsView.isHidden = true
        }
    }
}

extension DetailPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pokemon?.moves.count != nil{
            return (pokemon?.moves.count)!
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMoves", for: indexPath)
        
        if let label = cell.viewWithTag(1) as? UILabel {
            label.underline()
            label.text = pokemon?.moves[indexPath.row].move.name
        }
        return cell
    }
}

extension DetailPokemonViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}
