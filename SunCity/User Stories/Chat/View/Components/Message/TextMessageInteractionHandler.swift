//
//  TextMessageInteractionHandler.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

class TextMessageInteractionHandler: BaseMessageInteractionHandlerProtocol {

    typealias ViewModelT = TextMessageViewModel<TextMessageModel>

    func userDidTapOnFailIcon(viewModel: TextMessageViewModel<TextMessageModel>, failIconView: UIView) {}
    func userDidTapOnAvatar(viewModel: TextMessageViewModel<TextMessageModel>) {}
    func userDidTapOnBubble(viewModel: TextMessageViewModel<TextMessageModel>) {}
    func userDidBeginLongPressOnBubble(viewModel: TextMessageViewModel<TextMessageModel>) {}
    func userDidEndLongPressOnBubble(viewModel: TextMessageViewModel<TextMessageModel>) {}
    func userDidSelectMessage(viewModel: TextMessageViewModel<TextMessageModel>) {}
    func userDidDeselectMessage(viewModel: TextMessageViewModel<TextMessageModel>) {}

}
