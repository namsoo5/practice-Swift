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
    var testList = ["1","1","2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self //print(UIDevice.current.identifierForVendor?.uuidString)
        
        
    }
    
    @IBAction func disconnetSocket(_ sender: Any) {
        SocketIOManager.shared.closeConnection()
    }
    @IBAction func connectSocket(_ sender: Any) {
        LocalChatService.shared.getMemoList(id: self.id){ data in
            self.roomList = data.room
            self.tableView.reloadData()
            SocketIOManager.shared.establishConnection()
        }
        
    }
    
    @IBAction func sendData(_ sender: Any) {
        SocketIOManager.shared.sendMessage(message: self.textField.text!, withNickname: "ns")
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
