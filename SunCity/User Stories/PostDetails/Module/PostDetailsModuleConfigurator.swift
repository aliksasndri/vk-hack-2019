//
//  PostDetailsModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class PostDetailsModuleConfigurator {

    typealias Module = (PostDetailsViewController, PostDetailsModuleOutput)

    func configure() -> Module {
        let view: PostDetailsViewController = PostDetailsViewController.fromStoryboard()
        return (view, view)
    }

}
