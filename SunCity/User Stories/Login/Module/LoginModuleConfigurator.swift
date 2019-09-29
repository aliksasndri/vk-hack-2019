//
//  LoginModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class LoginModuleConfigurator {

    typealias Module = (LoginViewController, LoginModuleOutput)

    func configure() -> Module {
        let view: LoginViewController = LoginViewController.fromStoryboard()
        return (view, view)
    }

}
