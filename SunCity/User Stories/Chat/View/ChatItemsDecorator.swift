//
//  ChatItemsDecorator.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class ChatItemsDecorator: ChatItemsDecoratorProtocol {

    private enum Constants {
        static let shortSeparation: CGFloat = 3
        static let normalSeparation: CGFloat = 10
        static let timeIntervalThresholdToIncreaseSeparation: TimeInterval = 120
    }

    func decorateItems(_ chatItems: [ChatItemProtocol]) -> [DecoratedChatItem] {
        var decoratedChatItems: [DecoratedChatItem] = []
        let calendar: Calendar = .current

        for (index, chatItem) in chatItems.enumerated() {
            let next: ChatItemProtocol? = (index + 1 < chatItems.count) ? chatItems[index + 1] : nil
            let prev: ChatItemProtocol? = (index > 0) ? chatItems[index - 1] : nil

            var additionalItems = [DecoratedChatItem]()
            let bottomMargin = separationAfterItem(chatItem, next: next)
            var showsTail = false
            var addTimeSeparator = false

            if let currentMessage = chatItem as? MessageModelProtocol {
                if let nextMessage = next as? MessageModelProtocol {
                    showsTail =
                        currentMessage.senderId != nextMessage.senderId
                        || !calendar.isDate(currentMessage.date, inSameDayAs: nextMessage.date)
                } else {
                    showsTail = true
                }

                if let previousMessage = prev as? MessageModelProtocol {
                    addTimeSeparator = !calendar.isDate(currentMessage.date, inSameDayAs: previousMessage.date)
                } else {
                    addTimeSeparator = true
                }

                if self.showsStatusForMessage(currentMessage) {
                    additionalItems.append(
                        DecoratedChatItem(
                            chatItem: SendingStatusModel(
                                uid: "\(currentMessage.uid)-decoration-status",
                                status: currentMessage.status
                            ),
                            decorationAttributes: nil)
                    )
                }

                if addTimeSeparator {
                    let dateTimeStamp = DecoratedChatItem(
                        chatItem: TimeSeparatorModel(uid: "\(currentMessage.uid)-time-separator",
                        date: currentMessage.date.toWeekDayAndDateString()),
                        decorationAttributes: nil
                    )
                    decoratedChatItems.append(dateTimeStamp)
                    showsTail = showsTail && addTimeSeparator
                }
            }

            let attributes = BaseMessageDecorationAttributes(
                canShowFailedIcon: false,
                isShowingTail: showsTail,
                isShowingAvatar: showsTail,
                isShowingSelectionIndicator: false,
                isSelected: false
            )

            let decoratedChatItem = DecoratedChatItem(
                chatItem: chatItem,
                decorationAttributes: ChatItemDecorationAttributes(
                    bottomMargin: bottomMargin,
                    messageDecorationAttributes: attributes
                )
            )
            decoratedChatItems.append(decoratedChatItem)
            decoratedChatItems.append(contentsOf: additionalItems)
        }

        return decoratedChatItems
    }

    private func separationAfterItem(_ current: ChatItemProtocol?, next: ChatItemProtocol?) -> CGFloat {
        guard let nexItem = next else {
            return 0
        }
        guard let currentMessage = current as? MessageModelProtocol else {
            return Constants.normalSeparation
        }
        guard let nextMessage = nexItem as? MessageModelProtocol else {
            return Constants.normalSeparation
        }

        if showsStatusForMessage(currentMessage) {
            return 0
        } else if currentMessage.senderId != nextMessage.senderId {
            return Constants.normalSeparation
        } else if nextMessage.date.timeIntervalSince(currentMessage.date) > Constants.timeIntervalThresholdToIncreaseSeparation {
            return Constants.normalSeparation
        } else {
            return Constants.shortSeparation
        }
    }

    private func showsStatusForMessage(_ message: MessageModelProtocol) -> Bool {
        return message.status == .failed || message.status == .sending
    }

}
