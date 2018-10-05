//
//  UIViewExtension.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 17/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
