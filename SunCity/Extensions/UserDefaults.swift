//
//  UserDefaults.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation

extension UserDefaults {

    var token: String? {
        get { return object(forKey: #function) as? String }
        set { set(newValue, forKey: #function) }
    }

    var apns: String? {
        get { return object(forKey: #function) as? String }
        set { set(newValue, forKey: #function) }
    }

}
