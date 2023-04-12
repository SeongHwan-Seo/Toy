//
//  MainView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/12.
//

import SwiftUI

struct MainView: View {
    let viewModel = HomeVM()
    @State var nameText = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter your name", text: $nameText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                
                    NavigationLink(destination: {
                        Text("dd")
                    }, label: {
                        Text("Start")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    })
                    .simultaneousGesture(TapGesture().onEnded{
                        print("gg")
                        //viewModel.setName(name: nameText)
                    })
                    .frame(width: 80, height: 40)
                    .background(Color.mainColor)
                    .cornerRadius(10)
                
            }
            .padding()
            
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
