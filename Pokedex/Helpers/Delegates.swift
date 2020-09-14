//
//  Delegates.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

protocol ReloadViewDelegate{
    
    func reloadView()
    func errorReload(message:String)
}
