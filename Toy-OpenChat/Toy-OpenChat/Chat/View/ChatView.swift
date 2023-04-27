//
//  ChatView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/13.
//

import SwiftUI

struct ChatView: View {
    let name: String
    @State private var messageText = ""
    @StateObject var viewModel = ChatVM()
    
    var body: some View {
       
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.message, id: \.id) { message in
                                MessageView(message: message, name: name)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .onChange(of: viewModel.scrollToEnd, perform: { value in
                            if value {
                                withAnimation {
                                    proxy.scrollTo(viewModel.message.last?.id, anchor: .bottom)
                                }
                                viewModel.scrollToEnd = false
                            }
                        })
                        
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                HStack {
                    TextField("메시지 보내기...", text: $messageText)
                    Button("Send") {
                        if messageText == "" { return }
                        viewModel.sendMessage(messageText, name)
                        messageText = ""
                    }
                }
                .padding()
                
            }
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(name: "")
    }
}
