//
//  AppConstants.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 02/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
typealias Dictionary = [String: Any] //make it globally accessible

struct AppConstants {
    private init() {}
    enum CellIdentifiers: String {
        case photoGalleryTableCell = "PhotoGalleryCell"
        case searchCollectionCell = "collectionViewCell"
    }

    static let PageSize: Int = 20
}
