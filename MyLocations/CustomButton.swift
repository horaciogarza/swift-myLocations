//
//  CustomButton.swift
//  MyLocations
//
//  Created by Horacio Garza on 10/21/16.
//  Copyright © 2016 kickinbahk Productions. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class customButton: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
