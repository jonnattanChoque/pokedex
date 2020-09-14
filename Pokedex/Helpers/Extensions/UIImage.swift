//
//  UIImage.swift
//  Pokedex
//
//  Created by MacBook Retina on 13/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
                
        do {
          self.init(data: try Data(contentsOf: url))
        } catch {
          print("Cannot load image from url: \(url) with error: \(error)")
          return nil
        }
    }
}
