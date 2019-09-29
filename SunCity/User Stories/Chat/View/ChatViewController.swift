//
//  ChatViewController.swift
//  SunCity
//
//  Created by Ivan Smetanin on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

final class ChatViewController: BaseChatViewController, ChatModuleOutput {

    // MARK: - ChatModuleOutput

    // MARK: - Properties

    var chatInputPresenter: BasicChatInputBarPresenter!
    private var dataSource: ChatDataSource? {
        return chatDataSource as? ChatDataSource
    }

    // MARK: - BaseChatViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        chatDataSource = ChatDataSource()
        dataSource?.start()
        chatItemsDecorator = ChatItemsDecorator()
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.93, alpha: 1)
    }

    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputView()
        var appearance = ChatInputBarAppearance()
        appearance.textInputAppearance.placeholderText = "Введите сообщение"
        appearance.textInputAppearance.font = UIFont.systemFont(ofSize: 15)
        appearance.textInputAppearance.placeholderFont = UIFont.systemFont(ofSize: 15)
        appearance.textInputAppearance.textInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 4)
        chatInputView.maxCharactersCount = 1000
        chatInputView.setAppearance(appearance)
        chatInputView.onSend = { [weak self] text in
            self?.dataSource?.add(message: text)
        }
        return chatInputView
    }

    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let builder = TextMessageViewModelBuilder()
        let interactionHandler = TextMessageInteractionHandler()
        let menuPresenter = TextMessageMenuItemPresenter()
        let textMessagePresenter = MessagePresenterBuilder(
            viewModelBuilder: builder,
            interactionHandler: interactionHandler,
            menuPresenter: menuPresenter
        )

        let colors = BaseMessageCollectionViewCellDefaultStyle.Colors(
            incoming: .white,
            outgoing: UIColor(red: 0.31, green: 0.55, blue: 0.16, alpha: 1)
        )
        let style = BaseMessageCollectionViewCellAvatarStyle(colors: colors)
        textMessagePresenter.baseMessageStyle = style
        textMessagePresenter.textCellStyle = TextMessageCollectionViewCellDefaultStyle(baseStyle: style)

        return [
            MessageModel.chatItemType: [textMessagePresenter],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()]
        ]
    }


}
