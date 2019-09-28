//
//  MessageModel.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class MessageModel: MessageModelProtocol {

    static var chatItemType: ChatItemType {
        return "text-message-type"
    }

    var text: String
    var avatarImage: Observable<UIImage?>
    var senderId: String
    var isIncoming: Bool
    var date: Date
    var status: MessageStatus
    var type: ChatItemType
    var uid: String

    init(text: String, avatarImage: Observable<UIImage?>,
         senderId: String, isIncoming: Bool,
         date: Date, status: MessageStatus,
         uid: String) {
        self.text = text
        self.avatarImage = avatarImage
        self.senderId = senderId
        self.isIncoming = isIncoming
        self.date = date
        self.status = status
        self.type = MessageModel.chatItemType
        self.uid = uid
    }

}

extension MessageViewModelStatus {

    init(from status: MessageStatus) {
        switch status {
        case .failed:
            self = .failed
        case .sending:
            self = .sending
        case .success:
            self = .success
        }
    }

}
