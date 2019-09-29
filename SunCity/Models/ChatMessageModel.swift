//
//  ChatMessageModel.swift
//  SunCity
//
//  Created by Александр Кравченков on 29/09/2019.
//  Copyright © 2019 i.smetanin. All rights reserved.
//

import Foundation
import NodeKit

struct User: Codable {
    let apns: String
    let description: String
    let id: String
    let partner: String?
    let image: String
    let name: String?
    let userType: UserType

    enum CodingKeys: String, CodingKey {
        case apns = "Apns"
        case description = "Description"
        case id = "ID"
        case image = "Image"
        case name = "Name"
        case userType = "UserType"
        case partner = "Partner"
    }
}

struct ChatMessageModel: Codable  {

    let recipient: String
    let text: String
    let sender: User?
    let time: String
    let isMe: Bool

    var date: Date {
        return Formatter.iso8601.date(from: time) ?? Date()
    }


    enum CodingKeys: String, CodingKey {
        case recipient
        case text = "Text"
        case sender
        case time
        case isMe = "IsMe"
    }
}

struct StartChat: Codable, DTODecodable, RawDecodable  {

    typealias DTO = StartChat

    typealias Raw = Json

    let partnerId: String
    let messages: [ChatMessageModel]

    static func from(dto: StartChat) throws -> StartChat {
        return dto
    }
}


extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        if #available(iOS 11.3, *) {
            return ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
        } else {
            return ISO8601DateFormatter([.withInternetDateTime])
        }
    }()
}
