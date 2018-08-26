//
//  AppEnums.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 30/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

enum HTTPResponseCode: Int {
    case HTTPResponseCode400 = 400  // Bad Request
    case HTTPResponseCode404 = 404  // Not found
    case HTTPResponseCode401 = 401  // Unauthorized acess
    case HTTPResponseCode503 = 503  // Service down
    case HTTPResponseCode200 = 200  // Success
    case HTTPResponseCode201 = 201  // Created
}
