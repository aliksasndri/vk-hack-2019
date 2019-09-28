//
//  ActivityModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ActivityModuleConfigurator {

    typealias Module = (ActivityViewController, ActivityModuleOutput)

    func configure() -> Module {
        let view: ActivityViewController = ActivityViewController.fromStoryboard()
        return (view, view)
    }

}
