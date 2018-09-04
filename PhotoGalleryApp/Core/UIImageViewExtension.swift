//
//  UIImageViewExtension.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 04/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadFromLink(link: String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask(with: URL(string: link)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
