//
//  MessageViewModel.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

class MessageViewModel: MessageViewModelProtocol {

    // MARK: - MessageViewModelProtocol

    var decorationAttributes: BaseMessageDecorationAttributes
    var isIncoming: Bool
    var isUserInteractionEnabled: Bool
    var isShowingFailedIcon: Bool
    var date: String
    var status: MessageViewModelStatus
    var avatarImage: Observable<UIImage?>

    // MARK: - Initialization and deinitialization

    init(with model: MessageModel) {
        self.decorationAttributes = BaseMessageDecorationAttributes()
        self.isIncoming = model.isIncoming
        self.isUserInteractionEnabled = true
        self.isShowingFailedIcon =  false
        self.date = DateFormatter.HHmm.string(from: model.date)
        self.status = MessageViewModelStatus(from: model.status)
        self.avatarImage = model.avatarImage
    }

}
