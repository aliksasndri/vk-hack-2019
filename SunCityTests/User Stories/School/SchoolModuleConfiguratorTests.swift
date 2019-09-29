//
//  SchoolModuleConfiguratorTests.swift
//  SunCity
//
//  Created by Ivan Smetanin on 29/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import XCTest

@testable import SunCity

final class SchoolModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(
            name: String(describing: SchoolViewController.self),
            bundle: Bundle.main
        ).instantiateInitialViewController() == nil {
            XCTFail("Can't load SchoolViewController from storyboard")
        }
    }

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = SchoolModuleConfigurator().configure()
            return (view, [])
        })
    }

}
