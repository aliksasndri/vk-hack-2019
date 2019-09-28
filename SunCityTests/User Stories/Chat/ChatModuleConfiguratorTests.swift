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

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, _) = ChatModuleConfigurator().configure()
            return (view, [])
        })
    }

}
