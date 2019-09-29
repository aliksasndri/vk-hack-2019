//
//  StubModuleConfigurator.swift
//  SunCity
//
//  Created by Alexander Kravchenkov on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class StubModuleConfigurator {

    typealias Module = (StubViewController, StubModuleOutput)

    func configure() -> Module {
        let view: StubViewController = StubViewController.fromStoryboard()
        return (view, view)
    }

}
