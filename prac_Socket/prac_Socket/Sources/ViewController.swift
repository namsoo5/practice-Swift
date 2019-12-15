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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var socket: SocketIOClient!
    let id = "1"
    var roomList: [String] = []
    //    var testList = ["1","1","2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self //print(UIDevice.current.identifierForVendor?.uuidString)
        socket = SocketIOManager.shared.socket
        SocketIOManager.shared.establishConnection(room: "") {
         print("set socket")
        }
        bindMsg()
    }
    
    @IBAction func disconnetSocket(_ sender: Any) {
        SocketIOManager.shared.closeConnection()
    }
    @IBAction func connectSocket(_ sender: Any) {
        LocalChatService.shared.getTestChatList(id: self.id){ data in
            print("success")
            self.roomList = data.room
            self.tableView.reloadData()

        }
    }
    
    @IBAction func sendData(_ sender: Any) {
        SocketIOManager.shared.sendMessage(message: self.textField.text!, withNickname: "ns")
    }
    
    // 서버로부터 메시지 받을때 채팅창 업데이트
       func bindMsg() {
           self.socket.on("chat-msg") { (dataArray, socketAck) in
            print("***************************************")
            print(dataArray)
            print(type(of: dataArray))
            let data = dataArray[0] as! NSDictionary
            let name = data["name"] as! String
            let msg = data["message"] as! String
            
            print("name: \(name), msg: \(msg) 통신!")
            
            
           }
       }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "room", for: indexPath)
        cell.textLabel?.text = roomList[indexPath.row]
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomText = roomList[indexPath.row]
        
        SocketIOManager.shared.establishConnection(room: roomText) {
            
            let nextVC = self.storyboard?.instantiateViewController(identifier: "Room") as! SecondViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
