//
//  ViewController.swift
//  PhotoGalleryApp


import UIKit
import Foundation

struct Welcome: Codable {
    let photos: Photos
    let stat: String
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

class LandingViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    var imageDataSource: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPhotos()
    }
    func createDataSource() {
       self.imageDataSource = ["first","second"]
    }

    func fetchPhotos() {
        let params : [String : Any] = [
            KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
            KeyConstants.FetchPhotos.tags.rawValue: "observatory",
            KeyConstants.FetchPhotos.api_key.rawValue: "f32611f39f86cdb703a0b1305ffd9099",
            KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
            KeyConstants.FetchPhotos.format.rawValue: "json",
            ]
        FetchService().fetchPhotos(params: params) { (response, data) in
            if data != nil {
                if let photosData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let photos = photosData!["photos"] as? [String: Any]
                    if let photo = photos!["photo"] as? [[String: Any]] {
                        for index in photo {
                            let farmID = index["farm"]
                            let serverID = index["server"]
                            let id = index["id"]
                            let secret = index["secret"]
                            let imageURL = "https://farm\(farmID!).staticflickr.com/\(serverID!)/\(id!)_\(secret!).jpg"
                            self.imageDataSource.append(imageURL)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }

    func imageFromURL(url: URL) -> UIImage? {
        var image: UIImage?
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            image = UIImage(data: imageData)
        }
        return image
    }
}

//MARK: TableView datasource and delegate methods
extension LandingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "PhotoGalleryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if let imageURL = try? imageDataSource[indexPath.row] .asURL() {
            cell?.imageView?.image = imageFromURL(url: imageURL)  ?? #imageLiteral(resourceName: "circle")
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

