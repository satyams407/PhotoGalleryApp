//
//  ProfileViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 23/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var sda: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavedPhotos()
        // Do any additional setup after loading the view.
    }

    func fetchSavedPhotos() {
        let photosObject = CoreDataUtil.fetchObjectsFromCoreData(fetchRequest: Photos.fetchRequest(), predicate: nil)
        print(photosObject)
    }
}

extension ProfileViewController {

}
