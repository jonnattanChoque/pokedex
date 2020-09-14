//
//  ApiRequest.swift
//  Pokedex
//
//  Created by MacBook Retina on 12/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


public class ApiRequest{
    static let sharedInstance = ApiRequest()
    private var baseUrl = Common.APIRest.URL_API
    
    func getData<T>(dec: T.Type, endpoint: String, completion: @escaping (_ data: Any) -> Void) where T : Decodable{
        let url = "\(baseUrl)/\(endpoint)"
        AF.request(url).responseDecodable(of: dec.self) { (response) in
            guard let data = response.value else { return }
            
            completion(data)
        }
    }
    
    func getImagePokemon(endpoint: String, completion: @escaping (_ image: String) -> Void){
        let url = "\(baseUrl)/\(endpoint)"
        AF.request(url).responseDecodable(of: myPokemon.self) { (response) in
            
            guard let data = response.value else { return }
            let image = data.sprites.frontDefault
            
            completion(image)
        }
    }
}

