//
//  StartModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class StartModuleConfigurator {

    typealias Module = (StartViewController, StartModuleOutput)

    func configure() -> Module {
        let view: StartViewController = StartViewController.fromStoryboard()
        return (view, view)
    }

}
