//
//  ReceiveMessage.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import Foundation

struct ReceiveMessage: Decodable {
    var event: String?
    var data: String?
    var channel: String?
    
    var messageData: MessageData? {
        guard let data = data?.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(MessageData.self, from: data)
    }
}

struct MessageData: Decodable, Equatable {
    var id: String?
    var username: String?
    var profileImage: String?
    var message: String?
    var createdAt: String?
}
