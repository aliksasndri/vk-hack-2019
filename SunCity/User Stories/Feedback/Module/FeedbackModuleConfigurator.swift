//
//  FeedbackModuleConfigurator.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class FeedbackModuleConfigurator {

    typealias Module = (FeedbackViewController, FeedbackModuleOutput)

    func configure() -> Module {
        let view: FeedbackViewController = FeedbackViewController.fromStoryboard()
        return (view, view)
    }

}
