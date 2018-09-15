//
//  SearchViewViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 01/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    let kcornerRadius: CGFloat = 10.0
    var debounceTimer: Timer?

    @IBOutlet weak var hikingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface(for: searchBar)
        screenSetupForButtons()
    }

    func screenSetupForButtons() {
        //hikingButton.setImage(#imageLiteral(resourceName: "hiking"), for: .normal)
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
        KeyConstants.FetchPhotos.format.rawValue: "json",
        KeyConstants.FetchPhotos.per_page.rawValue: AppConstants.PageSize,
        KeyConstants.FetchPhotos.sort.rawValue : "interestingness-desc",
    ]

    private var url = URL.init(string: APIURLConstants.searchPhotos.urlString())

    @IBAction func categoryButtonAction(_ sender: UIButton) {
        params[KeyConstants.FetchPhotos.tags.rawValue] = sender.currentTitle
        FetchPhotoService(url!, params: params).fetch  { (photoArray, error)  in
        }
    }

    // MARK: Collection view datasource and delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "searchcollectionviewcell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        return cell
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
