//
//  ItemNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class ItemNetwork{
    func search(){
        ApiRequest.sharedInstance.getData(dec: Items.self, endpoint: "item") { (data) in
            let result:[String: Items] = ["result": data as! Items];
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Item.searchNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
}
