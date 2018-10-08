//
//  ImageViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 08/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String = ""

    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
       // bookmark the image and save the url in core data object
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage()
        // Do any additional setup after loading the view.
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
