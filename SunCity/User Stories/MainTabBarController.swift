//
//  MainTabBarController.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Nested types

    enum Tab: Int {
        case activity
        case school
        case chats

        var title: String {
            switch self {
            case .activity:
                return "Активность"
            case .school:
                return "Школа"
            case .chats:
                return "Общалка"
            }
        }

        var image: UIImage {
            switch self {
            case .activity:
                return UIImage(named: "tabHome") ?? UIImage()
            case .school:
                return UIImage(named: "tabSchool") ?? UIImage()
            case .chats:
                return UIImage(named: "tabChat") ?? UIImage()
            }
        }

        var selectedImage: UIImage {
            return image
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isTranslucent = false
    }

}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(_: UITabBarController, didSelect viewController: UIViewController) {

    }

    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        return true
    }

}
