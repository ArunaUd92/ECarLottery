//
//  RoundImageView.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 4/23/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
    }
    
}
