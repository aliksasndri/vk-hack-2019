//
//  ChatModuleConfiguratorTests.swift
//  SunCity
//
//  Created by Ivan Smetanin on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import XCTest

@testable import SunCity

final class ChatModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testThatViewControllerLoadsCorrectly() {
        if UIStoryboard(
            name: String(describing: ChatViewController.self),
            bundle: Bundle.main
        ).instantiateInitialViewController() == nil {
            XCTFail("Can't load ChatViewController from storyboard")
        }
    }

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = ChatModuleConfigurator().configure()
            return (view, [])
        })
    }

}
