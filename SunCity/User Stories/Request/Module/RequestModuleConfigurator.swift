//
//  RequestModuleConfigurator.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class RequestModuleConfigurator {

    typealias Module = (RequestViewController, RequestModuleOutput)

    func configure() -> Module {
        let view: RequestViewController = RequestViewController.fromStoryboard()
        return (view, view)
    }

}
