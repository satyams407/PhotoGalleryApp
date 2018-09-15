//
//  LandingViewModel.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 30/07/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import Alamofire


class LandingViewModel {

    private var url = URL.init(string: APIURLConstants.searchPhotos.urlString())
    var dataSourceArray = [PhotoCellModel]()

    func fetchPhotos(params: Dictionary, completion: @escaping (PhotoCellModel?, AppError?) -> Void) {
        guard let rm = NetworkReachabilityManager(), rm.isReachable == true else {
            let appError = AppError(with: .networkError, message: "Please check your connection")
            completion(nil, appError)
            return
        }

        FetchPhotoService(url!, params: params).fetch  { (photoArray, error)  in
            completion(nil,error)
        }
    }
}


/*
class LandingViewModel {
    typealias DictionaryObject = [String: Any]
    let fetchService = FetchPhotoService()
    var dataSourceArray = [PhotoCellModel]()

    func fetchPhotos(params: DictionaryObject, completionHandler completion: @escaping ([PhotoCellModel]?, AppError?) -> Void) {

        if !(NetworkReachabilityManager()?.isReachable)! {
            // Offine case
            completion(nil, AppError.init(with: .networkError, error: nil, message: "Currently the Server could not be accessed. Please check your connection", code: nil))
        } else {
            fetchService.fetchPhotos(params: params) { (response, data) in
                guard let data = data else {
                    let error = AppError.init(with: AppError.ErrorType.paramsError, error: nil, message: "Unable to fetch data", code: nil)
                    completion(nil, error)
                    return
                }

                if let photosData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let photos = photosData![KeyConstants.photosData.photos.rawValue] as? [String: Any]
                    if let photo = photos![KeyConstants.photosData.photo.rawValue] as? [[String: Any]] {
                        for index in photo {
                            let farmID = index[KeyConstants.photosData.farm.rawValue]
                            let serverID = index[KeyConstants.photosData.server.rawValue]
                            let id = index[KeyConstants.photosData.id.rawValue]
                            let secret = index[KeyConstants.photosData.secret.rawValue]
                            var photoCellModel: PhotoCellModel? = PhotoCellModel()
                            photoCellModel!.imageURL = "https://farm\(farmID!).staticflickr.com/\(serverID!)/\(id!)_\(secret!).jpg"
                            photoCellModel!.title = index[KeyConstants.photosData.title.rawValue] as! String

                            self.dataSourceArray.append(photoCellModel!)
                            photoCellModel = nil
                        }
                        completion(self.dataSourceArray, nil)
                    } else {
                        completion(nil, nil)
                    }
                } else {
                    let error = AppError.init(with: AppError.ErrorType.paramsError, error: nil, message: "Unable to fetch data", code: nil)
                    completion(nil, error)
                }
            }
        }
    }
}
 */
