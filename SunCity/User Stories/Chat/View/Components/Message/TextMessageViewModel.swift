//
//  TextMessageViewModel.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

open class TextMessageViewModel<TextMessageModelT: TextMessageModelProtocol>: TextMessageViewModelProtocol {

    open var text: String {
        return textMessage.text
    }

    public let textMessage: TextMessageModelT
    public let messageViewModel: MessageViewModelProtocol
    public let cellAccessibilityIdentifier = "chatto.message.text.cell"
    public let bubbleAccessibilityIdentifier = "chatto.message.text.bubble"

    public init(textMessage: TextMessageModelT, messageViewModel: MessageViewModelProtocol) {
        self.textMessage = textMessage
        self.messageViewModel = messageViewModel
    }

    open func willBeShown() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }

    open func wasHidden() {
        // Need to declare empty. Otherwise subclass code won't execute (as of Xcode 7.2)
    }
}
