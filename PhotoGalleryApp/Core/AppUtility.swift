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
 
    static func showAlert(title: String? = StringConstants.emptyString, message: String, onController controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let dismissAction = UIAlertAction.init(title: StringConstants.okButtonTitle, style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(dismissAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
