//
//  ViewController.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/11/19.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            print("******")
            print(ack.expected)
        }

        socket.on("currentAmount") {data, ack in
            guard let cur = data[0] as? Double else { return }
            
            self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
                self.socket.emit("update", ["amount": cur + 2.50])
            }
            
            ack.with("Got your currentAmount", "dude")
            ack.with("hihi")
        }
        socket.connect()
        socket.didConnect(toNamespace: "/test")
        socket.handleAck(1, data: ["hi"])
    }
    
    
    @IBAction func connectSocket(_ sender: Any) {
        
    }
    
    @IBAction func sendData(_ sender: Any) {
        
    }
    
    
}

