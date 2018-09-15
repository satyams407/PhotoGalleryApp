//
//  FetchPhotos.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 30/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import Alamofire

struct PhotoResponse: Codable {
    let stat: String
    let photos: Photos
}

struct Photos: Codable {
    let page: Int
    let pages: String
    let perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

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
            guard let jsonData = response.data,
               let photos = try? JSONDecoder().decode(PhotoResponse.self, from: jsonData),
                let photoArray = photos as? [Photo] else {
                   // completion(PhotoResult.failure(AppError))
                    return
            }
            completion(photoArray, nil)
        })
    }
}

