//
//  SendingStatusModel.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

class SendingStatusModel: ChatItemProtocol {

    static var chatItemType: ChatItemType {
        return "decoration-status"
    }

    let uid: String
    let status: MessageStatus

    var type: String {
        return SendingStatusModel.chatItemType
    }

    init(uid: String, status: MessageStatus) {
        self.uid = uid
        self.status = status
    }

}
