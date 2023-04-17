//
//  ChatVM.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/13.
//

import Foundation
import Starscream
import SwiftyJSON

class ChatVM: ObservableObject {
    
    @Published var message = [MessageData]()
    @Published var scrollToEnd = false
    private var socket: WebSocket?
    //    private let socketUrl = "소켓주소"
    //    private let postUrl = "포스트요청주소"
    private let socketUrl = URL(string: "wss://ws-ap3.pusher.com:443/app/bd0b7360f2c92f6cff54")!
    private let postUrl = URL(string: "https://phplaravel-574671-3402493.cloudwaysapps.com/api/new-message")!
    
    init() {
        connect()
    }
    
    func connect() {
        let request = URLRequest(url: socketUrl)
        self.socket = WebSocket(request: request)
        self.socket?.delegate = self
        self.socket?.connect()
    }
    
    func disconnect() {
        self.socket?.disconnect()
    }
    
    func sendMessage(_ message: String) {
        var sendMessage = SendMessage()
        
        sendMessage.id = UUID().uuidString
        sendMessage.message = message
        sendMessage.username = UserDefaults.standard.string(forKey: "name") ?? ""
        sendMessage.createdAt = sendMessage.dateToString()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(sendMessage)
            
            // URLRequest 생성
            var request = URLRequest(url: postUrl)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // URLSession으로 요청 보내기
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
            
            task.resume()
            
        } catch {
            print("JSON encoding error: \(error)")
        }
    }
    
    func socketSubscribe() {
        let dictionary = ["event": "pusher:subscribe", "data": ["channel": "public.room"]] as [String : Any]
        
        guard let jsonString = JSON(dictionary).rawString() else { return }
        
        self.socket?.write(string: jsonString, completion: {
            print("Subscribe completion")
        })
    }
}

extension ChatVM: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
            socketSubscribe()
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ReceiveMessage.self, from: Data(string.utf8))
                
                if result.event == "message.new" {
                    guard let data = result.messageData else { return }
                    message.append(data)
                    scrollToEnd = true
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("soket cancelled")
        case .error(let error):
            print("error : \(error?.localizedDescription)")
        }
    }
}
