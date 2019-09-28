//
//  TextMessageViewModelBuilder.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions

final class TextMessageViewModelBuilder: ViewModelBuilderProtocol {

    typealias ModelT = MessageModel
    typealias ViewModelT = TextMessageViewModel<TextMessageModel>

    func canCreateViewModel(fromModel model: Any) -> Bool {
        return true
    }

    func createViewModel(_ model: MessageModel) -> TextMessageViewModel<TextMessageModel> {
        return TextMessageViewModel(
            textMessage: TextMessageModel(messageModel: model, text: model.text),
            messageViewModel: MessageViewModel(with: model)
        )
    }

}
