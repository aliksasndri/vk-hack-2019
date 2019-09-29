//
//  FeedbackModuleConfiguratorTests.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 28/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import XCTest

@testable import SunCity

final class FeedbackModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(
            name: String(describing: FeedbackViewController.self),
            bundle: Bundle.main
        ).instantiateInitialViewController() == nil {
            XCTFail("Can't load FeedbackViewController from storyboard")
        }
    }

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = FeedbackModuleConfigurator().configure()
            return (view, [])
        })
    }

}
