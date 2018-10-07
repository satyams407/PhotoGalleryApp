//
//  PhotoGalleryCell.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 29/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class PhotoGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageview: UIImageView!

    var photoCellModel : PhotoCellModel?
    let defaultBackgroundColor = UIColor.groupTableViewBackground

    func updateCell(with photocell: PhotoCellModel) {
        self.title.text = photocell.title
        self.imageview.downloadFromLink(link: photocell.imageURL, contentMode: UIView.ContentMode.scaleAspectFill)
    }

    func configure(photoCell: PhotoCellModel) {
         setOpaqueBackground()
    }

    func setOpaqueBackground() {
        self.alpha = 1.0
        self.backgroundColor = defaultBackgroundColor
        imageview.alpha = 1.0
        imageview.backgroundColor = defaultBackgroundColor
    }
}
