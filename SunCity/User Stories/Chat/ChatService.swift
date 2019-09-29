//
//  ChatService.swift
//  SunCity
//
//  Created by Александр Кравченков on 29/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation
import NodeKit

class ChatService {

    func loadHistory() -> Observer<StartChat> {
        return UrlChainsBuilder()
            .load(with: .init(method: .get, route: "http://demo6.alpha.vkhackathon.com:8844/chat", metadata: ["Authorization": UserDefaults.standard.token ?? ""], encoding: .json))
            .process()
    }
}

extension UrlChainsBuilder {

    open func load<Output>(with config: UrlChainConfigModel) -> Node<Void, Output>
        where Output: DTODecodable, Output.DTO.Raw == Json {
            let input: Node<Json, Output> = self.defaultInput(with: config)
            let configNode = ChainConfiguratorNode<Json, Output>(next: input)
            let voidNode =  VoidInputNode(next: configNode)
            return LoggerNode(next: voidNode)
    }
}
