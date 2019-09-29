//
//  MessagePresenter.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class MessagePresenterBuilder: TextMessagePresenterBuilder<TextMessageViewModelBuilder, TextMessageInteractionHandler> {

    override var presenterType: ChatItemPresenterProtocol.Type {
        return MessagePresenter.self
    }

    public override func createPresenter(withChatItem chatItem: ChatItemProtocol,
                                 viewModelBuilder: TextMessageViewModelBuilder,
                                 interactionHandler: TextMessageInteractionHandler?,
                                 sizingCell: TextMessageCollectionViewCell,
                                 baseCellStyle: BaseMessageCollectionViewCellStyleProtocol,
                                 textCellStyle: TextMessageCollectionViewCellStyleProtocol,
                                 layoutCache: NSCache<AnyObject, AnyObject>,
                                 menuPresenter: TextMessageMenuItemPresenterProtocol?) -> TextMessagePresenter<TextMessageViewModelBuilder, TextMessageInteractionHandler> {
           assert(self.canHandleChatItem(chatItem))
            return MessagePresenter(
               messageModel: chatItem as! TextMessageViewModelBuilder.ModelT,
               viewModelBuilder: viewModelBuilder,
               interactionHandler: interactionHandler,
               sizingCell: sizingCell,
               baseCellStyle: baseCellStyle,
               textCellStyle: textCellStyle,
               layoutCache: layoutCache,
               menuPresenter: menuPresenter
           )
       }

}

final class MessagePresenter: TextMessagePresenter<TextMessageViewModelBuilder, TextMessageInteractionHandler> {

    override func createViewModel() -> TextMessageViewModel<TextMessageModel> {
        return super.createViewModel()
    }

    override func configureCell(_ cell: BaseMessageCollectionViewCell<TextBubbleView>, decorationAttributes: ChatItemDecorationAttributes, animated: Bool, additionalConfiguration: (() -> Void)?) {
        super.configureCell(
            cell,
            decorationAttributes: decorationAttributes,
            animated: animated,
            additionalConfiguration: additionalConfiguration
        )
        DispatchQueue.main.async {
            cell.avatarView.layer.cornerRadius = cell.avatarView.frame.size.width / 2
            cell.avatarView.clipsToBounds = true
        }
    }

}
