//
//  UILabel.swift
//  Pokedex
//
//  Created by MacBook Retina on 14/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
          attributedText = attributedString
        }
    }
}
