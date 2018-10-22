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
    var url : URL
    var params: Dictionary

    private var manager: Alamofire.SessionManager {
        return Alamofire.SessionManager.default
    }

    init(_ url: URL, params: Dictionary) {
        self.url = url
        self.params = params
    }

    func fetch(completion: @escaping (Any?, AppError?) -> Void) {
        manager.request(url, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            guard let jsonData = response.data
               //let photos = try? JSONDecoder().decode(PhotoResponse.self, from: jsonData),
               // let photoArray = Photos.self
                   else {
                   // completion(PhotoResult.failure(AppError))
                     return
            }
            completion(jsonData, nil)
        })
    }
}

