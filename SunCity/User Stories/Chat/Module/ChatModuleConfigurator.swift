//
//  ChatModuleConfigurator.swift
//  SunCity
//
//  Created by Ivan Smetanin on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class ChatModuleConfigurator {

    typealias Module = (ChatViewController, ChatModuleOutput)

    func configure() -> Module {
        let view: ChatViewController = ChatViewController()
        return (view, view)
    }

}
