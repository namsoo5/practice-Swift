//
//  SecondViewController.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/12/14.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import SocketIO
class SecondViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    var myChat: [chatType] = []
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket = SocketIOManager.shared.socket
        bindMsg()
        
        self.tableView.dataSource = self
        
    }
    
    func bindMsg() {
        self.socket.on("test") { (dataArray, socketAck) in
//            var messageDictionary = [String: AnyObject]()
            var chat = chatType()
            print("***************************************")
            print(type(of: dataArray))
            let data = dataArray[0] as! NSDictionary
            
            chat.type = data["type"] as! Int
            chat.message = data["message"] as! String
            self.myChat.append(chat)
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.myChat.count-1, section: 0)], with: .fade)
            self.tableView.endUpdates()
            print(chat)
            
        }
    }
    @IBAction func sendMsgButtonClick(_ sender: Any) {
        let text = self.textField.text!
        self.socket.emit("test", text)
        
        
        self.myChat.append(chatType(type: 0, message: text))
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: self.myChat.count-1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
}

struct chatType {
    var type = -1
    var message = ""
}

extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTVC!
        if self.myChat[indexPath.row].type == 0 { //my
            cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? ChatTVC
        }else { //otehr
            cell = tableView.dequeueReusableCell(withIdentifier: "YourCell", for: indexPath) as? ChatTVC
        }
         cell.chatLabel.text = self.myChat[indexPath.row].message
        
        return cell
    }
    
    
}
