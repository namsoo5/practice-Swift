//
//  SocketIOManager.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/12/13.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/test")
        
        socket.on("test") { dataArray, ack in
            print(dataArray)
        }
    }

    
    
    
    func establishConnection(){

        socket.connect()
    }
    
    func closeConnection(){
        socket.emit("disconnect")
        socket.disconnect()
    }
    
    func connectToServerWithNickname(nickname: String, completionHandler: (_ userList: [[String: AnyObject]]?)->Void){
//        socket.emit("connectUser", nickname)
//
//        socket.on("userList") { (dataArray, ack) in
//            completionHandler(dataArray[0] as? [[String: AnyObject]])
//        }
//
//        listenForOtherMessages()
        
    }
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("event",  ["message" : "This is a test message"])
        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
        socket.emit("msg", ["nick": nickname, "msg" : message])
        
    }
    
    func getChatMessage(completionHandler: ([String: AnyObject]) -> Void){
//        socket.on("newChatMessage") { (dataArray, socketAck) in
//            var messageDictionary = [String: AnyObject]()
//            messageDictionary["nickname"] = dataArray[0] as! String
//            messageDictionary["message"] = dataArray[1] as! String
//            messageDictionary["date"] = dataArray[2] as! String
//
//            completionHandler(messageInfo: messageDictionary)
//        }
    }
    private func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: dataArray[0] as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasDisconnectedNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userTypingNotification"), object: dataArray[0] as? [String: AnyObject])
        }
    }
}
