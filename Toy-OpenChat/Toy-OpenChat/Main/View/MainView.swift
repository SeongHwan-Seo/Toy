//
//  MainView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/12.
//

import SwiftUI

struct MainView: View {
    let viewModel = HomeVM()
    @AppStorage("name") private var name = ""
    @State var stack = NavigationPath()
    var isDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var body: some View {
        NavigationStack(path: $stack) {
            ZStack {
                Color.white
                
                VStack(spacing: 20) {
                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                    
                    NavigationLink(destination: {
                        ChatView(name: name)
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
            .onTapGesture {
                hideKeyboard()
            }
            
            .navigationTitle("PPAK-OpenChat")
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
