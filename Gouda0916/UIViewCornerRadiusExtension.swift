//
//  UIViewCornerRadiusExtension.swift
//  Gouda0916
//
//  Created by Douglas Galante on 12/20/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
