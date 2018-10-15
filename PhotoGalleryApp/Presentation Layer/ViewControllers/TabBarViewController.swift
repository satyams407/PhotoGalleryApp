//
//  TabBarViewController.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 01/09/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

enum tabs: Int {
    case home
    case search
    case profile
}

struct tabBarItemData {
    var title: String
    var image: UIImage
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setData()
        setUpLocalNotifications()
        self.selectedIndex = 1
    }

    func setData() {
        guard let items = self.tabBar.items else {
            return
        }
        for index in 0..<items.count {
            let item = items[index]
            let itemData = createDataSource(for: index)
            item.image = itemData.image
            item.title = itemData.title
        }
    }

    func createDataSource(for index: Int) -> tabBarItemData {
        var title = ""
        var image = #imageLiteral(resourceName: "home")
        switch index {
        case tabs.home.rawValue:
            title =  StringConstants.TabBarConstants.home
            image =  #imageLiteral(resourceName: "home")
        case tabs.search.rawValue:
            title = StringConstants.TabBarConstants.search
            image = #imageLiteral(resourceName: "search")
        case tabs.profile.rawValue:
            title = StringConstants.TabBarConstants.profile
            image = #imageLiteral(resourceName: "profile")
        default:
            break
        }
        return tabBarItemData(title: title, image: image)
    }

    func setUpLocalNotifications() {
        let content = UNMutableNotificationContent.init()
        content.title = "Title"
        content.body = "body of notication"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "INVITATION"

        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest.init(identifier: "testNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
