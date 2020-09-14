//
//  DetailGenerationViewController.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class DetailGenerationViewController: UIViewController, ReloadViewDelegate {
    
    @IBOutlet weak var myView: UIView!
    
    private var DequeueReusableCell = "DequeueReusableCell"
    var myCollectionView:UICollectionView?
    var myTableView:UITableView?
    var id = 0
    var generationDetail: GenerationDetail? = nil
    var loader: Loading?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = Loading(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50, y: 100, width: 100, height: 100), image: UIImage(named: "pokedex")!)
        view.addSubview(loader!)
        
        createCollection()
        createTable()
        
        self.myView.addSubview(myCollectionView!)
        loadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadInfo(){
        loader?.startAnimating()
        GenerationModelNetwork.shared.delegate = self
        GenerationModelNetwork.shared.detail(id: self.id)
    }
    
    func createCollection(){
        let viewCollection = UIView()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 2, bottom: 10, right: 2)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        myCollectionView!.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DequeueReusableCell)
        myCollectionView?.backgroundColor = UIColor.white
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        viewCollection.addSubview(myCollectionView ?? UICollectionView())
    }
    
    func createTable(){
        myTableView = UITableView(frame: self.view.frame)
        myTableView!.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: DequeueReusableCell)
        myTableView!.dataSource = self
    }
    
    //MARK: Protocols
    func reloadView() {
        if GenerationModelNetwork.shared.detail != nil{
            generationDetail = GenerationModelNetwork.shared.detail
            myCollectionView?.reloadData()
            self.myTableView?.reloadData()
            loader?.stopAnimating()
        }
    }
    
    func errorReload(message: String) {
        print("b")
    }
    
    

    @IBAction func segmentedPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.myView.addSubview(myCollectionView!)
        }else{
            self.myView.addSubview(myTableView!)
        }
    }
    
}

extension DetailGenerationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if generationDetail?.pokemonSpecies.count != nil{
            return (generationDetail?.pokemonSpecies.count)!
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PokemonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DequeueReusableCell, for: indexPath) as! PokemonCollectionViewCell
        let data = generationDetail?.pokemonSpecies
        let row = indexPath.row
        let object = data![row]
        
        cell.display(for: object)
        return cell
    }
}

extension DetailGenerationViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

extension DetailGenerationViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if generationDetail?.types.count != nil{
            return (generationDetail?.types.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DequeueReusableCell) as? ItemTableViewCell
        let data = generationDetail?.types
        let object = data![indexPath.row]
        
        cell?.display(img: object.name, name: object.name)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100;
    }
}

