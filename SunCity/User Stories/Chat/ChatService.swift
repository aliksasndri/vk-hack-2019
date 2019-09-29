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
            .default(with: .init(method: .get, route: "http://demo6.alpha.vkhackathon.com:8844/chat", metadata: ["Authorization": UserDefaults.standard.token ?? ""], encoding: .json))
            .process()
    }

    func loadData(relative: String) -> Observer<Data> {
        return UrlChainsBuilder().loadData(with: .init(method: .get, route: "http://demo6.alpha.vkhackathon.com:8844" + relative)).process()
    }
}
