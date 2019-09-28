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

    // MARK: - BaseChatViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatDataSource = ChatDataSource()
        self.chatItemsDecorator = ChatItemsDecorator()
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
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()

        return [
            MessageModel.chatItemType: [textMessagePresenter],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()]
        ]
    }

    // MARK: - Private methods

    private func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
//        items.append(self.createPhotoInputItem())
        return items
    }

    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { text in
            // Your handling logic
            print("Input text: \(text)")
        }
        return item
    }

    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { image, source in
            // Your handling logic
            print("Photo input handler. Image: \(image), source: \(source)")
        }
        return item
    }

}
