//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController, ReloadViewDelegate {

    @IBOutlet weak var pokeTableView: UITableView!
    
    private var DequeueReusableCell = "DequeueReusableCell"
    private var pokemons : [Pokemon] = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: DequeueReusableCell)
        pokeTableView.tableFooterView = UIView(frame: CGRect.zero)
        pokeTableView.separatorColor = UIColor.gray
        pokeTableView.preservesSuperviewLayoutMargins = false
        pokeTableView.separatorInset = UIEdgeInsets.zero
        pokeTableView.layoutMargins = UIEdgeInsets.zero
        
        self.pokeTableView.delegate = self
        self.pokeTableView.dataSource = self
        
        loadInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailPokemonSegue"{
            let destination = segue.destination as? DetailPokemonViewController
            let index = pokeTableView.indexPathForSelectedRow?.row
            let object = pokemons[index!]
            let id = object.url.split(separator: "/")[5]
            let name = object.name
            
            destination?.name = name
            destination?.id = Int.init(String(id))!
        }
    }
    
    func loadInfo(){
        PokemonModelNetwork.shared.delegate = self
        PokemonModelNetwork.shared.search()
    }
    
    func reloadView() {
        if PokemonModelNetwork.shared.pokemons.count > 0{
            pokemons = PokemonModelNetwork.shared.pokemons
            self.pokeTableView.reloadData()
        }
    }
    
    func errorReload(message: String) {
        print(message)
    }
}
extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DequeueReusableCell) as? PokemonTableViewCell
        let data = pokemons
        let object = data[indexPath.row]
        cell?.display(for: object)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailPokemonSegue", sender: indexPath)
    }
}

