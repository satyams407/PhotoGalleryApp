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
    var landingViewModel = LandingViewModel()
    var nextPageNo: Int = 0
    let totalPages = 10
    let tableCellHeight: CGFloat = 350.0

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        screenSetupForTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  activityIndicatorView.startAnimating()
        self.fetchAllPhotos()
    }

    func fetchAllPhotos(searchText: String? = "himalayas") {
        let params : [String : Any] = [
            KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
            KeyConstants.FetchPhotos.tags.rawValue: searchText!,
            KeyConstants.FetchPhotos.api_key.rawValue: "f32611f39f86cdb703a0b1305ffd9099",
            KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
            KeyConstants.FetchPhotos.format.rawValue: "json",
            KeyConstants.FetchPhotos.per_page.rawValue: AppConstants.PageSize,
            KeyConstants.FetchPhotos.sort.rawValue : "interestingness-desc",
            KeyConstants.FetchPhotos.page.rawValue: self.totalPages
        ]

        landingViewModel.fetchPhotos(params: params) { (cellModel, appError) in
            guard let cellModel = cellModel else {
                AppUtility.showAlert(message: (appError?.message)!, onController: self)
                self.activityIndicatorView.stopAnimating()
                return
            }
//            for index in cellModel {
//                self.imageDataSource.append(index)
//            }
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
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
            cell.configure(photoCell: photo)
        }


        return tableCell!
    }

    // MARK: Paging Support
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.imageDataSource.count
        if  indexPath.row == count - 1 {
            self.nextPageNo += 1
           // fetchAllPhotos()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
}
