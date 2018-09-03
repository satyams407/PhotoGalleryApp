//
//  KeyConstants.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 30/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

class KeyConstants {

    enum FetchPhotos: String {
        case method
        case format
        case nojsoncallback
        case privacy_filter
        case api_key
        case tags
        case per_page
        case size
        case sort
        case page
    }

    enum photosData: String {
        case photo
        case photos
        case farm
        case server
        case id
        case secret
        case title
        case imageURL
    }
}
