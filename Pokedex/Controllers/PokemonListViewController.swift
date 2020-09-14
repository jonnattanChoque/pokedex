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
    private var searchBar:UISearchBar = UISearchBar()
    private var searchCounter:Int = 0;
    var limit = 0
    let totalEnteries = 1040
    
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
        createSearchBar()
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
        PokemonModelNetwork.shared.search(offset: 0)
    }
    
    func createSearchBar(){
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Pokemon"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        if let textfield = textFieldInsideUISearchBar{
            setDoneOnKeyboard(textField:textfield)
        }
    }
    
    func setDoneOnKeyboard(textField:UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSearchKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    func reloadView() {
        if PokemonModelNetwork.shared.pokemons.count > 0{
            pokemons.append(contentsOf: PokemonModelNetwork.shared.pokemons)
            self.pokeTableView.reloadData()
        }
    }
    
    func errorReload(message: String) {
        print(message)
    }
    
    func loadMore(next: Int){
        PokemonModelNetwork.shared.search(offset: next)
    }
    
    func filter(name: String){
        pokemons = pokemons.filter( { $0.name.range(of: name, options: .caseInsensitive) != nil})
        self.pokeTableView.reloadData()
    }
    
    @objc func dismissSearchKeyboard() {
        searchBar.endEditing(true)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            if pokemons.count < totalEnteries {
                let index = pokemons.count
                limit = index + 50
                loadMore(next: limit)
            }
        }
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let stext = searchBar.text{
            if !stext.isEmpty{
                self.filter(name: stext)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            searchCounter = searchCounter + 1;
            if searchCounter > 2{
                self.filter(name: searchText)
            }
        }else{
            self.pokeTableView.reloadData()
        }
    }
    
    func addSearchDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissSearchKeyboard))
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap)
    }
}

