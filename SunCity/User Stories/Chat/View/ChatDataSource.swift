//
//  ChatDataSource.swift
//  SunCity
//
//  Created by i.smetanin on 28/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Chatto
import ChattoAdditions
import Starscream
import NodeKit

final class ChatDataSource: ChatDataSourceProtocol {

    private var socket: WebSocket?
    private var recivier: String = ""

    // MARK: - Initialization and deinitialization

    init() {
        self.recivier = ""
        self.socket = nil
        self.chatItems = []
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
        var newMessage = MessageModel(
            text: message,
            avatarImage: Observable(UIImage(named: "dr")),
            senderId: "2",
            isIncoming: false,
            date: Date(),
            status: .success, uid: UUID().uuidString
        )

        let model = ChatMessageModel(recipient: "5d8fa55f09773ae35d7d1d4b", text: message, sender: nil, time: "", isMe: true)

        let data = try! JSONEncoder().encode(model)

        self.socket?.write(data: data) { [weak self] in

            guard let self = self else { return }

            self.delegate?.chatDataSourceDidUpdate(self, updateType: .normal)

            newMessage.status = .success
            self.delegate?.chatDataSourceDidUpdate(self, updateType: .normal)
        }


        chatItems.append(newMessage)
        delegate?.chatDataSourceDidUpdate(self, updateType: .normal)
    }

    func configureSocket() {
        var request = URLRequest(url: URL(string: "ws://demo6.alpha.vkhackathon.com:8844/ws")!)
        request.timeoutInterval = 5
        request.setValue(UserDefaults.standard.token, forHTTPHeaderField: "Authorization")
        self.socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }

    func start() {

        self.configureSocket()

        ChatService().loadHistory().onCompleted { data in
            self.recivier = data.partnerId
            let msg = data.messages.map { item in
                return MessageModel(text: item.text,
                                    avatarImage: .init(nil),
                                    senderId: item.sender?.id ?? "f",
                                    isIncoming: !item.isMe,
                                    date: item.date,
                                    status: .success,
                                    uid: UUID().uuidString)
            }

            self.chatItems.append(contentsOf: msg)
            self.delegate?.chatDataSourceDidUpdate(self, updateType: .reload)
        }.onError {
            dump($0)
        }
    }
}


// MARK: - WebSocketDelegate

extension ChatDataSource: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("DID CONNECT")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("RECIVE ERROR\(error)")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {


        let data = Data(text.utf8)

        let dt = try! JSONDecoder().decode(ChatMessageModel.self, from: data)

        var newMessage = MessageModel(
            text: dt.text,
            avatarImage: Observable(UIImage(named: "dr")),
            senderId: dt.sender!.id,
            isIncoming: !dt.isMe,
            date: Date(),
            status: .success, uid: UUID().uuidString
        )

        chatItems.append(newMessage)
        delegate?.chatDataSourceDidUpdate(self, updateType: .normal)
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("RECIVE DATA")
    }
}

extension String: UrlRouteProvider {
    public func url() throws -> URL {

        guard let url = URL(string: self) else {
            throw URLError(URLError.Code(rawValue: 0))
        }

        return url
    }
}
