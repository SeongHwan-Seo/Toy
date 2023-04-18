//
//  SplashView.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 20) {
                Text("P")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .frame(width: 67.62, height: 67.62, alignment: .center)
                    .background(Color.mainColor)
                    .foregroundColor(.white)
                    .cornerRadius(19)
                Text("PPAK-OpenChat")
                    .font(.system(size: 25, weight:.bold, design: .rounded))
                    .foregroundColor(.mainColor)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

