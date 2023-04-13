//
//  MessageView.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/13.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let message: MessageData
    let myName = UserDefaults.standard.string(forKey: "name")
    
    var body: some View {
        HStack {
            if message.username ==  myName{
                Spacer()
                makeBallonView(foregroundColor: .white, backgroundColor: .mainColor, corners: [.topLeft, .topRight, .bottomLeft])
            } else {
                HStack {
                    makeProfileView()
                    makeBallonView(foregroundColor: Color.black, backgroundColor: Color(.lightGray), corners: [.topLeft, .topRight, .bottomRight])
                }
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func makeProfileView() -> some View {
        KFImage(URL(string: message.profileImage ?? ""))
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 32, height: 32)
        
    }
    
    @ViewBuilder
    private func makeBallonView(foregroundColor: Color, backgroundColor: Color, corners: UIRectCorner) -> some View {
        
        Text(message.message ?? "")
            .font(.system(size: 16, weight: .light))
            .foregroundColor(foregroundColor)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .cornerRadius(15, corners: corners)
    }
}



struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: MessageData())
    }
}
