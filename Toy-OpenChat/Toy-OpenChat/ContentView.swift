//
//  ContentView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/12.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true
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
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
