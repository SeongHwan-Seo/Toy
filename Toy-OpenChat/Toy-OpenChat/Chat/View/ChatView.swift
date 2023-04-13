//
//  ChatView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/13.
//

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    @StateObject var viewModel = ChatVM()
    
    var body: some View {
        ZStack {
            Color.clear
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.message, id: \.id) { message in
                            MessageView(message: message)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
                HStack {
                    TextField("메시지 보내기...", text: $messageText)
                    Button("Send") {
                        viewModel.sendMessage(messageText)
                        messageText = ""
                    }
                }
                .padding()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
