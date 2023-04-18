//
//  ContentView.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import SwiftUI
import ComposableArchitecture
import Starscream

struct MessageState: Equatable {
    var messages = [MessageData]()
    var scrollToEnd = false
    
    
}

enum MessageAction: Equatable {
    case connect
    //case subscribe
    case sendMessage(_ msg: String)
    //case receivedMessage(MessageData)
}

struct MessageEnvironment {
    var messageClinet: MessageClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let messageReducer = Reducer<MessageState, MessageAction, MessageEnvironment> { state, action, environment in
    
    struct messageCancelId: Hashable {}
    
    switch action {
    case .sendMessage(let str):
        environment.messageClinet.sendMessage(str)
        return .none
    case .connect:
        environment.messageClinet.connect()
        return .none
    }
    
}

let store = Store<MessageState, MessageAction>(initialState: MessageState(), reducer: messageReducer, environment: MessageEnvironment(messageClinet: MessageClient.live, mainQueue: .main))

struct HomeView: View {
    let store: Store<MessageState, MessageAction>
    
    @State var isLoading = true
    @State var stack = NavigationPath()
    
    var body: some View {
        if isLoading {
            SplashView()
                .onAppear {
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        withAnimation {
                            isLoading = false
                        }
                    }
                }
        }
        else {
            NavigationStack(path: $stack) {
                MainView(store: store)
                
                    .navigationTitle("PPAK-OpenChat")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
        
    }
}

struct MainView: View {
    let store: Store<MessageState, MessageAction>
    @State var nameText = ""
    var isDisabled: Bool {
        nameText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 20) {
                TextField("Enter your name", text: $nameText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                
                NavigationLink(destination: {
                    ChatView(store: store)
                }, label: {
                    Text("Start")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .frame(width: 80, height: 40)
                .background{
                    isDisabled ? Color.gray : Color.mainColor
                }
                .cornerRadius(10)
                .disabled(isDisabled)
                
            }
            .padding()
        }
    }
}
