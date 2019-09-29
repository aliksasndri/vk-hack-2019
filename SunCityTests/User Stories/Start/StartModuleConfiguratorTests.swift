//
//  StartModuleConfiguratorTests.swift
//  SunCity
//
//  Created by Ivan Smetanin on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import XCTest

@testable import SunCity

final class StartModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(
            name: String(describing: StartViewController.self),
            bundle: Bundle.main
        ).instantiateInitialViewController() == nil {
            XCTFail("Can't load StartViewController from storyboard")
        }
    }

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = StartModuleConfigurator().configure()
            return (view, [])
        })
    }

}
