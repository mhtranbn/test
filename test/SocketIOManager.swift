//
//  SocketIOManager.swift
//  test
//
//  Created by mhtran on 2/7/17.
//  Copyright © 2017 mhtran. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    override init() {
        super.init()
    }
    
    let socket = SocketIOClient(socketURL: URL(string: "http://192.168.5.15:3000")!, config: [.log(true), .forcePolling(true)])
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func connectToServerWithNickname(nickname: String, completionHandler: (_ userList: [[String: AnyObject]]?) -> Void) {
        socket.emit("connectUser", nickname)
    }
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as AnyObject?
            messageDictionary["message"] = dataArray[1] as AnyObject?
            messageDictionary["date"] = dataArray[2] as AnyObject?
            
            completionHandler(messageDictionary)
        }
    }
    
    
    
    fileprivate func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "userWasConnectedNotification"), object: dataArray[0] as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "userWasDisconnectedNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "userTypingNotification"), object: dataArray[0] as? [String: AnyObject])
        }
    }
    
    
    func sendStartTypingMessage(_ nickname: String) {
        socket.emit("startType", nickname)
    }
    
    
    func sendStopTypingMessage(_ nickname: String) {
        socket.emit("stopType", nickname)
    }
    
}
