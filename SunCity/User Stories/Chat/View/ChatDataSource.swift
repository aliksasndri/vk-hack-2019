//
//  ChatDataSource.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class ChatDataSource: ChatDataSourceProtocol {

    // MARK: - Initialization and deinitialization

    init() {
        let msg1 = MessageModel(
            text: "Сообщение 1",
            avatarImage: Observable(UIImage(named: "jj")),
            senderId: "1",
            isIncoming: true,
            date: Date(timeIntervalSince1970: 10),
            status: .success,
            uid: "1"
        )
        let msg2 = MessageModel(
            text: "Сообщение 2",
            avatarImage: Observable(UIImage(named: "jj")),
            senderId: "1",
            isIncoming: true,
            date: Date(),
            status: .success,
            uid: "2"
        )
        let msg3 = MessageModel(
            text: "Сообщение 3",
            avatarImage: Observable(UIImage(named: "jj")),
            senderId: "1",
            isIncoming: true,
            date: Date(),
            status: .success,
            uid: "3"
        )
        let msg4 = MessageModel(
            text: "Че?",
            avatarImage: Observable(UIImage(named: "dr")),
            senderId: "2",
            isIncoming: false,
            date: Date(),
            status: .success,
            uid: "4"
        )
        let msg5 = MessageModel(
            text: "Че ты вообще несешь такое? Успокойся уже, а? Пожалуйста",
            avatarImage: Observable(UIImage(named: "dr")),
            senderId: "2",
            isIncoming: false,
            date: Date(),
            status: .success,
            uid: "5"
        )
        self.chatItems = [
            msg1,
            msg2,
            msg3,
            msg4,
            msg5
        ]
    }

    // MARK: - ChatDataSourceProtocol

    var hasMoreNext: Bool {
        return false
    }

    var hasMorePrevious: Bool {
        return false
    }

    var chatItems: [ChatItemProtocol]

    var delegate: ChatDataSourceDelegateProtocol? = nil

    // Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func loadNext() {
        print(#function)
    }

    // Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func loadPrevious() {
        print(#function)
    }

    // If you want, implement message count contention for performance, otherwise just call completion(false)
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) {
        print(#function)
    }

    // MARK: - Internal methods

    func add(message: String) {
        let newMessage = MessageModel(
            text: message,
            avatarImage: Observable(UIImage(named: "dr")),
            senderId: "2",
            isIncoming: false,
            date: Date(),
            status: .sending, uid: "todo"
        )
        chatItems.append(newMessage)
        delegate?.chatDataSourceDidUpdate(self, updateType: .normal)
    }

}
