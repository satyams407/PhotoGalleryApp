//
//  ViewController.swift
//  PhotoGalleryApp


import UIKit
import Foundation

class LandingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var debounceTimer: Timer?
    var imageDataSource = [PhotoCellModel]()
    let tableCellHeight: CGFloat = 350.0

    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetupForTableView()
        createDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
        self.fetchAllPhotos()
    }

    func createDataSource() {
       //self.imageDataSource = ["first","second"]
    }

    func fetchAllPhotos(searchText: String? = "observatory") {
        let params : [String : Any] = [
            KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
            KeyConstants.FetchPhotos.tags.rawValue: searchText!,
            KeyConstants.FetchPhotos.api_key.rawValue: "f32611f39f86cdb703a0b1305ffd9099",
            KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
            KeyConstants.FetchPhotos.format.rawValue: "json",
            KeyConstants.FetchPhotos.per_page.rawValue: 10
        ]
        FetchPhotoService().fetchPhotos(params: params) { (response, data) in
            if data != nil {
                if self.imageDataSource.count > 0 {
                    self.imageDataSource.removeAll()
                }
                if let photosData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    let photos = photosData![KeyConstants.photosData.photos.rawValue] as? [String: Any]
                    if let photo = photos![KeyConstants.photosData.photo.rawValue] as? [[String: Any]] {
                        for index in photo {
                            let farmID = index[KeyConstants.photosData.farm.rawValue]
                            let serverID = index[KeyConstants.photosData.server.rawValue]
                            let id = index[KeyConstants.photosData.id.rawValue]
                            let secret = index[KeyConstants.photosData.secret.rawValue]
                            var photoCellModel: PhotoCellModel?
                            photoCellModel = PhotoCellModel()
                            photoCellModel!.imageURL = "https://farm\(farmID!).staticflickr.com/\(serverID!)/\(id!)_\(secret!)_m.jpg"
                            photoCellModel!.title = index[KeyConstants.photosData.title.rawValue] as! String
                            self.imageDataSource.append(photoCellModel!)
                            photoCellModel = nil
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        activityIndicatorView.stopAnimating()
    }

    func screenSetupForTableView() {
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
    }
}

//MARK: TableView datasource and delegate methods
extension LandingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifiers.photoGalleryTableCell.rawValue)
        if let cell = tableCell as? PhotoGalleryTableViewCell {
            let photo = self.imageDataSource[indexPath.row]
            cell.updateCell(with: photo)
        }
        return tableCell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
}
