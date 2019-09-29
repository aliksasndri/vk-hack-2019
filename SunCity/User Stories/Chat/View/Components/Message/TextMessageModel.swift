//
//  TextMessageModel.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

class TextMessageModel: TextMessageModelProtocol {

    var messageModel: MessageModelProtocol
    var text: String

    init(messageModel: MessageModelProtocol, text: String) {
        self.messageModel = messageModel
        self.text = text
    }

    func hasSameContent(as anotherItem: ChatItemProtocol) -> Bool {
        if let anotherItem = anotherItem as? TextMessageModel {
            return text == anotherItem.text
        } else {
            return false
        }
    }

}
