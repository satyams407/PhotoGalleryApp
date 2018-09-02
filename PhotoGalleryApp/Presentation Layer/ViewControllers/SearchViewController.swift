//
//  SearchViewViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 01/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var debounceTimer: Timer?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
    }

    func createSearchBar() {
        searchBar.delegate = self
        searchBar.text = ""
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "Search Image"
        searchBar.showsCancelButton = true
        searchBar.showsSearchResultsButton = false
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.clear
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
