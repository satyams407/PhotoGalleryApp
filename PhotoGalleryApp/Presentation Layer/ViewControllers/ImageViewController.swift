//
//  ImageViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 08/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol BookMarkImageDelegate {
    func saveImage(imageURL: String)
}

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var delegate: BookMarkImageDelegate?
    var imageUrl: String = ""

    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        if CoreDataUtil.createNewObject(ofType: "Photos")?.setValue(self.imageUrl, forKey: "url") != nil {
            CoreDataUtil.saveContext()
        } else {
            AppUtility.showAlert(message: "error while saving the photo", onController: self)
        }
       // bookmark the image and save the url in core data object
       //  delegate?.saveImage(imageURL: self.imageUrl)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
        callBackWithCompletion(isOffline: true) { (status, value) in
            if status == true {
                print("user is in online state")
            }
        }
    }

    func setUpImage() {
        if imageUrl != "" {
            imageView.downloadFromLink(link: imageUrl, contentMode: .scaleToFill)
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImageViewController {
    //Mark: some practice test functions

    func callBack(index: Int, callback: (Int,Int) -> Void) {

    }

    func callBackWithCompletion(isOffline: Bool, completion: @escaping (Bool, String) -> Void) {
        completion(true,"")
    }


    func coreData() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UsersDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("123", forKey: "userID")
        newUser.setValue("username", forKey: "userName")
        do {
            try context.save()
        } catch {
            print("error while saving the data in local storage")
        }

        let _ = UUID().uuidString
    }
}
