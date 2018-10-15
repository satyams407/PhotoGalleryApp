//
//  SearchViewViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 01/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit
import Alamofire

@objc protocol testProtocol {
    @objc func testfucntion()
}
class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var hikingButton: UIButton!
    @IBOutlet weak var lifeStyleButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var fitnessButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!

    let kcornerRadius: CGFloat = 10.0
    let itemPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 20.0)

    var debounceTimer: Timer?
    var dataSourceArray = [PhotoCellModel]()
    var imageURL: String = StringConstants.emptyString

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface(for: searchBar)
        screenSetupForButtons()
        fetchAllPhotos(searchText: "random")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            let destinationVC = segue.destination as! ImageViewController
            if let indexPath = sender as? IndexPath {
                destinationVC.imageUrl = dataSourceArray[indexPath.row].imageURL
                destinationVC.delegate = self
            }
        }
    }

    func screenSetupForButtons() {
        hikingButton.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: kcornerRadius)
        lifeStyleButton.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: 10.0)
        fitnessButton.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: kcornerRadius)
        musicButton.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: kcornerRadius)
        sportsButton.roundCorners([.topLeft,.topRight, .bottomLeft, .bottomRight], radius: kcornerRadius)
    }

    func imageBackgroundSetUpForButtons(sender: UIButton) {
    }

    func setUpUserInterface(for searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.text = ""
        searchBar.placeholder = "Search Image"
        searchBar.showsCancelButton = true
        searchBar.showsSearchResultsButton = false
        searchBar.enablesReturnKeyAutomatically = false
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.clear
        }

        let whiteImage = UIImage(color: .clear, size: CGSize(width: 200, height: 200))
        searchBar.backgroundImage = whiteImage
        searchBar.layer.cornerRadius = kcornerRadius

        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 2.0
        searchBar.backgroundColor = .white
    }

    var params : [String : Any] = [
        KeyConstants.FetchPhotos.method.rawValue : "flickr.photos.search",
        KeyConstants.FetchPhotos.api_key.rawValue: "f32611f39f86cdb703a0b1305ffd9099",
        KeyConstants.FetchPhotos.nojsoncallback.rawValue: 1,
        KeyConstants.FetchPhotos.format.rawValue: "json",
        KeyConstants.FetchPhotos.per_page.rawValue: AppConstants.PageSize,
        KeyConstants.FetchPhotos.sort.rawValue : "interestingness-desc",
        KeyConstants.FetchPhotos.page.rawValue: 5
    ]

    private var url = URL.init(string: APIURLConstants.searchPhotos.urlString())

    @IBAction func categoryButtonAction(_ sender: UIButton) {
        self.dataSourceArray.removeAll()
        self.fetchAllPhotos(searchText: sender.currentTitle ?? "")
    }

    func fetchAllPhotos(searchText: String) {
        params[KeyConstants.FetchPhotos.tags.rawValue] = searchText
        self.fetchPhotos(params: params) { (status, data) in
            guard let data = data else {
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
                }
            } else {
                print("error while fetching photos")
            }

            self.collectionView.reloadData()
        }
    }

    func fetchPhotos(params: [String: Any], completion: @escaping (HTTPResponseCode?, Data?) -> Void) {
        Alamofire.SessionManager.default.request(url!, method: .get, parameters: params).responseJSON(completionHandler: { (response) in
            if let httpStatusCode = response.response?.statusCode {
                let code = HTTPResponseCode(rawValue: httpStatusCode)
                completion(code, response.data)
            } else {
                completion(nil,nil)
            }
        })
    }
}

// MARK: Collection view datasource and delegate methods
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CellIdentifiers.searchCollectionCell.rawValue, for: indexPath)
        if let cell = collectionCell as? SearchResultCollectionViewCell, dataSourceArray.count > 0 {
            cell.updateCell(with: dataSourceArray[indexPath.row])
            cell.configure(photoCell: dataSourceArray[indexPath.row])
        }
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 2.5)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let imageVC = storyBoard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController {
            imageVC.imageUrl = dataSourceArray[indexPath.row].imageURL
        }
        self.performSegue(withIdentifier: "showImage", sender: indexPath)
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count > 2 {
            if let timer = debounceTimer {
                timer.invalidate()    // when search button is tapped multiple times
            }
            // start the timer
            debounceTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.updateSearchResult(_:)), userInfo: text, repeats: false)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = StringConstants.emptyString
    }


    @objc func updateSearchResult(_ timer: Timer) {
        if let searchText = timer.userInfo as? String {
           // self.fetchPhotos(searchText: searchText)
        }
        //self.scrollToTop()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .milliseconds(200)) {
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
            }
        }
    }

    func scrollToTop() {
        UIView.animate(withDuration: 0.3, animations: {
            //self.tableView.reloadData()
        }, completion: { (_) in
           // self.tableView.contentOffset = CGPoint.init(x: 0, y: 0)
        })
    }
}


extension SearchViewController: BookMarkImageDelegate {
    func saveImage(imageURL: String) {
        // Fetch user object from core data
        // update the bookmark array of the user
        // save the context
    }
}
