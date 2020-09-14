//
//  Loading.swift
//  Pokedex
//
//  Created by MacBook Retina on 14/09/20.
//  Copyright © 2020 Twon. All rights reserved.
//

import UIKit

class Loading: UIView {

    let imageView = UIImageView()

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)

        imageView.frame = bounds
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    func startAnimating() {
        isHidden = false
        self.imageView.rotate()
    }

    func stopAnimating() {
        isHidden = true
        self.imageView.removeRotation()
    }
}

extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func removeRotation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
}
