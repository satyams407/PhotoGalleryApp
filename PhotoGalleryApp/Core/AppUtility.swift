//
//  File.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 02/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {
    static func imageFromURL(url: URL) -> UIImage? {
        var image: UIImage?
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            image = UIImage(data: imageData)
        }
        return image
    }
}
