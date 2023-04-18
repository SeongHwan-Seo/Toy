//
//  MessageClient.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import Foundation
import ComposableArchitecture
import Starscream

struct MessageClient {
    var connect: () -> EffectPublisher<Void, Error>
    var sendMessage: (_ msg: String) -> EffectPublisher<Void, Error>
    
    struct Failure: Error, Equatable {}
}

extension MessageClient {
    static let live = MessageClient( connect: {
        SocketManager.shared
            .connect()
            .eraseToEffect()
    }, sendMessage: { msg in
        SocketManager.shared
            .sendMessage(msg)
            .eraseToEffect()
    })
}
