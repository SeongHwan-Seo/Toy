//
//  ChatView.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import SwiftUI
import ComposableArchitecture

struct ChatView: View {
    let store: Store<MessageState, MessageAction>
    @State private var messageText = ""
    
    var body: some View {
        WithViewStore(store.self) { viewStore in
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewStore.state.messages, id: \.id) { message in
                                MessageView(message: message)
                            }
                        }
                        //.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .onChange(of: viewStore.state.scrollToEnd, perform: { value in
                            if value {
                                withAnimation {
                                    proxy.scrollTo(viewStore.state.messages.last?.id, anchor: .bottom)
                                }
                                //viewStore.state.scrollToEnd = false
                            }
                        })
                        
                    }
                }
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
            .onAppear {
                viewStore.send(.connect)
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

