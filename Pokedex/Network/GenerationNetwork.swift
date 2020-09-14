//
//  GenerationNetwork.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation

class GenerationNetwork{
    func search(){
        ApiRequest.sharedInstance.getData(dec: Generations.self, endpoint: "generation") { (data) in
            let result:[String: Generations] = ["result": data as! Generations];
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Generation.searchNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
    
    func detail(id: Int){
        ApiRequest.sharedInstance.getData(dec: GenerationDetail.self, endpoint: "generation/\(id+1)") { (data) in
            let generationDetail = data as! GenerationDetail
            
            let result:[String: GenerationDetail] = ["result": generationDetail];
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:Notification.Name(rawValue:Common.Notifications.Generation.detailNotificationSuccess),object:nil,userInfo:result)
            }
        }
    }
}
