//
//  SendMessage.swift
//  Toy-OpenChat2
//
//  Created by SHSEO on 2023/04/17.
//

import Foundation

struct SendMessage: Encodable {
    var id: String?
    var username: String?
    var message: String?
    var createdAt: String?
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
