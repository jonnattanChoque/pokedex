//
//  GenerationModelNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class GenerationModelNetwork{
    static let shared = GenerationModelNetwork()
    
    public var generations : [Generation] = [Generation]()
    public var detail : GenerationDetail? = nil
    private var network: GenerationNetwork = GenerationNetwork()
    
    var delegate:ReloadViewDelegate? = nil
    
    init () {
        createObservers()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers(){
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Generation.searchNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Generation.searchNotificationError),object : nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(self.onSuccess(_:)),name:Notification.Name(rawValue:Common.Notifications.Generation.detailNotificationSuccess),object : nil)
        NotificationCenter.default.addObserver(self,selector:#selector(self.onError(_:)),name:Notification.Name(rawValue:Common.Notifications.Generation.detailNotificationError),object : nil)
    }
    
    @objc func onSuccess(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Generation.searchNotificationSuccess){
            
            if notification.userInfo?["result"] is Generations{
                let allInfo = (notification.userInfo?["result"] as! Generations)
                generations = allInfo.all
                notify()
            }
        }else if notification.name == Notification.Name(rawValue:Common.Notifications.Generation.detailNotificationSuccess){
            if notification.userInfo?["result"] is GenerationDetail{
                let allInfo = (notification.userInfo?["result"] as! GenerationDetail)
                detail = allInfo
                notify()
            }
        }
    }
    @objc func onError(_ notification: NSNotification){
        if notification.name == Notification.Name(rawValue:Common.Notifications.Generation.searchNotificationError){
            print("Search Model Error")
            generations = [Generation]()
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
    
    public func detail(id: Int){
        network.detail(id: id)
    }
}
