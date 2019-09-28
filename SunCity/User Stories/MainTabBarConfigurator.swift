//
//  MainTabBarConfigurator.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

final class MainTabBarConfigurator {

    // MARK: - Constants

    private let allTabs: [MainTabBarController.Tab] = [.activity, .school, .chats]

    // MARK: - MainTabBarCoordinatorOutput

    var finishFlow: (() -> Void)?

    // MARK: - Internal methods

    func configure() -> UITabBarController {
        let tabBarController = MainTabBarController()
        tabBarController.viewControllers = tabBarControllers()
        tabBarController.tabBar.tintColor = UIColor(red: 0.34, green: 0.59, blue: 0.18, alpha: 1)
        return tabBarController
    }

    // MARK: - Private methods

    private func tabBarControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()

        for tab in allTabs {
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image,
                selectedImage: tab.selectedImage
            )
            tabBarItem.tag = tab.rawValue
            navigationController.tabBarItem = tabBarItem
            viewControllers.append(navigationController)
        }

        return viewControllers
    }

}
