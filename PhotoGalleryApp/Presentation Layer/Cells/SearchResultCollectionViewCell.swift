//
//  SearchResultCollectionViewCell.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 16/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    var photoCellModel : PhotoCellModel?
    let defaultBackgroundColor = UIColor.groupTableViewBackground

    func updateCell(with photocell: PhotoCellModel) {
        self.imageView.downloadFromLink(link: photocell.imageURL, contentMode: UIViewContentMode.scaleAspectFill)
    }

    func configure(photoCell: PhotoCellModel) {
        setOpaqueBackground()
    }

    func setOpaqueBackground() {
        self.alpha = 1.0
        self.backgroundColor = defaultBackgroundColor
        imageView.alpha = 1.0
        imageView.backgroundColor = defaultBackgroundColor
    }
}
