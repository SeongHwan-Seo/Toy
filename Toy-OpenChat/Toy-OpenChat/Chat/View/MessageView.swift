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
    let name: String
    
    var body: some View {
        HStack {
            if message.username ==  name{
                HStack(spacing: 0) {
                    Spacer()
                    makeTime()
                        .padding(.trailing, 4)
                        .padding(.bottom, 1)
                    makeBallonView(foregroundColor: .white, backgroundColor: .mainColor, corners: [.topLeft, .topRight, .bottomLeft])
                }
                
            } else {
                HStack {
                    makeProfileView()
                    makeBallonView(foregroundColor: Color.black, backgroundColor: Color(.lightGray), corners: [.topLeft, .topRight, .bottomRight])
                    makeTime()
                        .padding(.bottom, 1)
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
    
    @ViewBuilder
    private func makeDate(dateString: String) -> some View {
        Text(dateString)
            .font(.system(size: 13, weight: .light))
            .foregroundColor(Color.black)
    }
    
    @ViewBuilder private func makeTime() -> some View {
        VStack(alignment: message.username ==  name ? .trailing : .leading, spacing: 0) {
            Spacer()
            Text(getRelativeTimeString(from: message.createdAt!) ?? "")
                .font(.system(size: 11, weight: .light))
                .foregroundColor(Color.black)
        }
    }
    
    private func getRelativeTimeString(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let now = Date()
        
        if let minuteDiff = calendar.dateComponents([.minute], from: date, to: now).minute, minuteDiff <= 1 {
            return "방금"
        } else if let hourDiff = calendar.dateComponents([.hour], from: date, to: now).hour, hourDiff <= 1 {
            let minuteDiff = calendar.dateComponents([.minute], from: date, to: now).minute ?? 0
            return "\(minuteDiff)분전"
        } else if let dayDiff = calendar.dateComponents([.day], from: date, to: now).day, dayDiff <= 1 {
            let hourDiff = calendar.dateComponents([.hour], from: date, to: now).hour ?? 0
            return "\(hourDiff)시간전"
        } else if let monthDiff = calendar.dateComponents([.month], from: date, to: now).month, monthDiff <= 1 {
            let dayDiff = calendar.dateComponents([.day], from: date, to: now).day ?? 0
            return "\(dayDiff)일전"
        } else if let yearDiff = calendar.dateComponents([.year], from: date, to: now).year, yearDiff <= 1 {
            let monthDiff = calendar.dateComponents([.month], from: date, to: now).month ?? 0
            return "\(monthDiff)달전"
        } else {
            let yearDiff = calendar.dateComponents([.year], from: date, to: now).year ?? 0
            return "\(yearDiff)년전"
        }
    }
    
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: MessageData(), name: "")
    }
}
