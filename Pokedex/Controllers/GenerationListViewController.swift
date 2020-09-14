//
//  GenerationListViewController.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class GenerationListViewController: UIViewController, ReloadViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var generation : [Generation] = [Generation]()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "detailGenerationSegue"{
            let destination = segue.destination as? DetailGenerationViewController
            let index = tableView.indexPathForSelectedRow?.row
            destination?.id = index!
        }
    }
    
    func loadInfo(){
        GenerationModelNetwork.shared.delegate = self
        GenerationModelNetwork.shared.search()
    }
    
    func reloadView() {
        if GenerationModelNetwork.shared.generations.count > 0{
            generation = GenerationModelNetwork.shared.generations
            self.tableView.reloadData()
        }
    }
    
    func errorReload(message: String) {
        print(message)
    }
}
extension GenerationListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = generation
        let row = indexPath.row
        let object = data[row]
        
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = ""
        cell.detailTextLabel?.backgroundColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailGenerationSegue", sender: indexPath)
    }
}

