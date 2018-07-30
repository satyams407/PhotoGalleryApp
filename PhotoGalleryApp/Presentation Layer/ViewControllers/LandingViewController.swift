//
//  ViewController.swift
//  PhotoGalleryApp


import UIKit

class LandingViewController: UIViewController {

    var dataSource: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
    }

    func createDataSource() {
       self.dataSource = ["first","second"]
    }
}

//MARK: TableView datasource and delegate methods
extension LandingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "PhotoGalleryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)

        cell?.imageView?.image = #imageLiteral(resourceName: "circle")
        return cell!
    }
}

