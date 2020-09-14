//
//  PokemonModelNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class PokemonModelNetwork{
    static let shared = PokemonModelNetwork()
    
    public var pokemons : [Pokemon] = [Pokemon]()
    public var specie : Specie?
    public var pokemon : myPokemon?
    private var network: PokemonNetwork = PokemonNetwork()
    
    var delegate:ReloadViewDelegate? = nil
    
    init () {
        createObservers()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.searchNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.searchNotificationError),object : nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.detailNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.detailNotificationError),object : nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.specieNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Pokemon.specieNotificationError),object : nil)
    }
    
    @objc func onSuccess(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Pokemon.searchNotificationSuccess){
            
            if notification.userInfo?["result"] is Pokemons{
                let allInfo = (notification.userInfo?["result"] as! Pokemons)
                pokemons = allInfo.all
                notify()
            }
        }else if notification.name == Notification.Name(rawValue:Common.Notifications.Pokemon.specieNotificationSuccess){
            if notification.userInfo?["result"] is Specie{
                let allInfo = (notification.userInfo?["result"] as! Specie)
                specie = allInfo
                notify()
            }
        }
        else if notification.name == Notification.Name(rawValue:Common.Notifications.Pokemon.detailNotificationSuccess){
            if notification.userInfo?["result"] is myPokemon{
                let allInfo = (notification.userInfo?["result"] as! myPokemon)
                pokemon = allInfo
                notify()
            }
        }
    }
    @objc func onError(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Pokemon.searchNotificationError){
            print("Search Model Error")
            pokemons = [Pokemon]()
            notifyError(message: "Error buscando")
        }
    }
    
    public func notify(){
        if delegate != nil{
            delegate?.reloadView()
        }
    }
    public func notifyError(message:String){
        print("delegate \(String(describing: delegate))")
        if delegate != nil{
            delegate?.errorReload(message: message)
        }
    }
    
    //MARK: Functions
    public func search(offset: Int){
        network.search(offset: offset)
    }
    
    public func detail(id: Int){
        network.detail(id: id)
    }
    
    public func specie(id: Int){
        network.specie(id: id)
    }
}
