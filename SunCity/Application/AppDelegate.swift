//
//  AppDelegate.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeRootView()
        return true
    }

    // MARK: - Private methods

    private func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
    }

    private func makeRootViewController() -> UIViewController {
        let (controller, _) = RequestModuleConfigurator().configure()
        return controller
    }

}

