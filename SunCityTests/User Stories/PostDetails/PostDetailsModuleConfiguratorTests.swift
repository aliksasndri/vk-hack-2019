//
//  PostDetailsModuleConfiguratorTests.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import XCTest

@testable import SunCity

final class PostDetailsModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(
            name: String(describing: PostDetailsViewController.self),
            bundle: Bundle.main
        ).instantiateInitialViewController() == nil {
            XCTFail("Can't load PostDetailsViewController from storyboard")
        }
    }

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = PostDetailsModuleConfigurator().configure()
            return (view, [])
        })
    }

}
