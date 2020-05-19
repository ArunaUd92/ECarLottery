//
//  UIImageView.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/13/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation

extension UIImageView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
