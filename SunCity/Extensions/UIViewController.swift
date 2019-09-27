//
//  UIViewController.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import UIKit

extension UIViewController {

    class func fromStoryboard<T: UIViewController>(isInitial: Bool = true) -> T {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        if isInitial {
            return storyboard.instantiateInitialViewController()! as! T
        } else {
            return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        }
    }

}
