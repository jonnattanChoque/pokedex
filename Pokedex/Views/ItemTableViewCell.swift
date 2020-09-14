//
//  ItemTableViewCell.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var myLbl: UILabel!
    @IBOutlet weak var myImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(img:String, name: String){
        print("------------------INICIO-------------------------")
        print(name)
        print("--------------------FIN-----------------------")
        myLbl.text = name
        myImg.image = UIImage(named: "pokedex")
    }
}
