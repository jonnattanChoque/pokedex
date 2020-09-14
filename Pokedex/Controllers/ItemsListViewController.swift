//
//  ItemsListViewController.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController, ReloadViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var DequeueReusableCell = "DequeueReusableCell"
    private var items : [Result] = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.gray
        tableView.preservesSuperviewLayoutMargins = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        loadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadInfo(){
        ItemsModelNetwork.shared.delegate = self
        ItemsModelNetwork.shared.search()
    }
    
    func reloadView() {
        if ItemsModelNetwork.shared.items.count > 0{
            items = ItemsModelNetwork.shared.items
            self.tableView.reloadData()
        }
    }
    
    func errorReload(message: String) {
        print(message)
    }
}

extension ItemsListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = items
        let row = indexPath.row
        let object = data[row]
        
        cell.textLabel?.text = object.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailPokemonSegue", sender: indexPath)
    }
}

