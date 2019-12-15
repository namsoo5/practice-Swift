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
        self.tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    // 뒤로가기시 소켓종료
    override func viewDidDisappear(_ animated: Bool) {
        SocketIOManager.shared.closeConnection()
    }
    
    // 서버로부터 메시지 받을때 채팅창 업데이트
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
            print(chat)
            
            self.updateChat(count: self.myChat.count) {
                print("Get Message")
            }
            
        }
    }
    
    func chatBackgroundView(color: UIColor, label: UILabel, cell: ChatTVC) -> UIView {
        let view = UIView()
        
        let width: CGFloat = CGFloat((label.text?.count ?? 1) * 14)
        let height = cell.contentView.frame.height
        
        view.frame.size = CGSize(width: width, height: height)
        view.backgroundColor = color
        guard let index = self.tableView.indexPath(for: cell) else{return UIView()}
        if self.myChat[index.row].type == 0 {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.
        }else {
            
        }
        
        view.layer.cornerRadius = CGFloat(10)
        
        return view
    }
    
    //채팅 업데이트
    func updateChat( count: Int, completion: @escaping ()->Void ) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.myChat.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
            
            let indexPath = IndexPath(
                row: count-1,
                section: 0
            )
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            
        }
        completion()
    }
    
    // 전송버튼
    @IBAction func sendMsgButtonClick(_ sender: Any) {
        let text = self.textField.text!
        self.socket.emit("test", text)
        
        
        self.myChat.append(chatType(type: 0, message: text))
        
        self.updateChat(count: self.myChat.count) {
            print("Send Message")
        }
        
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
        let chatBackground = chatBackgroundView(color: .white, label: cell.chatLabel, cell: cell)
        
        cell.insertSubview(chatBackground, belowSubview: cell.contentView)
        return cell
    }
}
