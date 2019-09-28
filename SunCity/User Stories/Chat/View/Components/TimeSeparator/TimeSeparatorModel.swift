//
//  TimeSeparatorModel.swift
//  SunCity
//
//  Created by i.smetanin on 27/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto

class TimeSeparatorModel: ChatItemProtocol {
    let uid: String
    let type: String = TimeSeparatorModel.chatItemType
    let date: String

    static var chatItemType: ChatItemType {
        return "TimeSeparatorModel"
    }

    init(uid: String, date: String) {
        self.date = date
        self.uid = uid
    }
}
