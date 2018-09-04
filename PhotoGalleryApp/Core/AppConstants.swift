//
//  AppConstants.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 02/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

struct AppConstants {
    private init() {}
    enum CellIdentifiers: String {
        case photoGalleryTableCell = "PhotoGalleryCell"
    }

    static let PageSize: Int = 15
}
