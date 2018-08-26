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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchPhotos()
    }
    func createDataSource() {
       self.dataSource = ["first","second"]
    }
    func fetchPhotos() {
        let params : [String : Any] = [
                 KeyConstants.FetchPhotos.SEARCH_METHOD.rawValue : "flickr.photos.search",
                 KeyConstants.FetchPhotos.API_KEY.rawValue: "f32611f39f86cdb703a0b1305ffd9099",
                 KeyConstants.FetchPhotos.FORMAT_TYPE.rawValue: "json",
                 KeyConstants.FetchPhotos.JSON_CALLBACK.rawValue: 1,
                 KeyConstants.FetchPhotos.PRIVACY_FILTER.rawValue: 1
            ]
        FetchService().fetchPhotos(params: params) { response , data in
            print(response)
        }

        
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

