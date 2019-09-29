//
//  SchoolModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class SchoolModuleConfigurator {

    typealias Module = (SchoolViewController, SchoolModuleOutput)

    func configure() -> Module {
        let view: SchoolViewController = SchoolViewController.fromStoryboard()
        return (view, view)
    }

}
