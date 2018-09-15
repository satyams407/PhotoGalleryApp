//
//  AppURLConstants.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 13/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

enum APIURLConstants {
    case searchPhotos

    func urlString() -> String {
        var urlString = ""
        switch self {
        case .searchPhotos:
            urlString = "https://api.flickr.com/services/rest/"

        }
        return urlString
    }
}
