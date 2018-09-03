//
//  FetchPhotos.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 30/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import Alamofire

class FetchPhotoService {

    var url = "https://api.flickr.com/services/rest/"
    var manager: Alamofire.SessionManager {
        return Alamofire.SessionManager.default
    }

    func fetchPhotos(params: [String: Any], completion: @escaping (HTTPResponseCode?, Data?) -> Void) {
        manager.request(url, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            if let httpStatusCode = response.response?.statusCode {
                let code = HTTPResponseCode(rawValue: httpStatusCode)
                completion(code, response.data)
            } else {
                completion(nil,nil)
            }
        })
    }
}

