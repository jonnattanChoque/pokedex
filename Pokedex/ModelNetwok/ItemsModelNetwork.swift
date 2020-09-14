//
//  ItemsModelNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class ItemsModelNetwork{
    static let shared = ItemsModelNetwork()
    
    public var items : [Result] = [Result]()
    private var network: ItemNetwork = ItemNetwork()
    
    var delegate:ReloadViewDelegate? = nil
    
    init () {
        createObservers()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Item.searchNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Item.searchNotificationError),object : nil)
    }
    
    @objc func onSuccess(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Item.searchNotificationSuccess){
            
            if notification.userInfo?["result"] is Items{
                let allInfo = (notification.userInfo?["result"] as! Items)
                items = allInfo.results
                notify()
            }
        }
    }
    @objc func onError(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Item.searchNotificationError){
            print("Search Model Error")
            items = [Result]()
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
    public func search(){
        network.search()
    }
}
