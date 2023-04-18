//
//  InputTextView.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/18.
//

import SwiftUI
import ComposableArchitecture

struct InputTextView: View {
    @Binding var messageText: String
    let store: Store<MessageState, MessageAction>
    
    var body: some View {
        WithViewStore(store.self) { viewStore in
            HStack {
                TextField("메시지 보내기...", text: $messageText)
                Button("Send") {
                    if messageText == "" { return }
                    viewStore.send(.sendMessage(messageText))
                    messageText = ""
                }
            }
            .padding()
        }
    }
}
