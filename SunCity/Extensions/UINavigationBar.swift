//
//  UINavigationBar.swift
//  SunCity
//
//  Created by i.smetanin on 29/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func applyTransparentStyle() {
        isTranslucent = true

        backgroundColor = UIColor.clear
        barTintColor = .white
        tintColor = .white

        backIndicatorImage = UIImage(named: "ic_back")
        backIndicatorTransitionMaskImage = UIImage(named: "ic_back")

        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }

}
