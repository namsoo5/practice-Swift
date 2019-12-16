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
    override func viewWillDisappear(_ animated: Bool) {
        SocketIOManager.shared.closeConnection()
    }
    
    // 서버로부터 메시지 받을때 채팅창 업데이트
    func bindMsg() {
        self.socket.on("test") { (dataArray, socketAck) in
            
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
    
    
    // 채팅 업데이트
    func updateChat( count: Int, completion: @escaping ()->Void ) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.myChat.count-1, section: 0)], with: .none)
            self.tableView.endUpdates()
            
            let indexPath = IndexPath(
                row: count-1,
                section: 0
            )
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            completion()
        }
        
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
        let view = UIView()
        let msg = self.myChat[indexPath.row].message
        
        if self.myChat[indexPath.row].type == 0 { //my Chat
            cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? ChatTVC
            
            // 말풍선 설정
            let size = CGSize(width: cell.chatLabel.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
            view.frame = CGRect(x: self.view.frame.width - estimatedFrame.width - 40 - 5, y:cell.chatLabel.frame.origin.y - 5 , width: estimatedFrame.width + 20, height: estimatedFrame.height + 10)
            view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 184/255, alpha: 1.0)
            
        }else { //otehr Chat
            cell = tableView.dequeueReusableCell(withIdentifier: "YourCell", for: indexPath) as? ChatTVC
            
            // 말풍선 설정
            let size = CGSize(width: cell.chatLabel.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
            view.frame = CGRect(x: cell.contentView.frame.origin.x + 30 , y:cell.chatLabel.frame.origin.y-5 , width: estimatedFrame.width + 20, height: estimatedFrame.height + 10)
            view.backgroundColor = UIColor.white
        }
        
        cell.chatLabel.text = msg
        
        // 말풍선 구현
        
        
        // 글자수에 비례한 넓이 cell.chatLabel.text?.lengthOfBytes(using: .utf8) ?? 1
        //        let byteLength = cell.chatLabel.text?.count ?? 1
        
        //        var width = CGFloat(byteLength * 16)
        //
        //        if width > 250 {
        //            width = 250
        //        }
        
        //        let height = cell.contentView.frame.height
        
        
        view.layer.cornerRadius = 7
        
        cell.addSubview(view)
        // Label이 가려지지않도록 설정
        cell.sendSubviewToBack(view)
        
        // 말풍선 오토레이아웃
        //        if self.myChat[indexPath.row].type == 0 {
        //            view.translatesAutoresizingMaskIntoConstraints = false
        //            view.trailingAnchor.constraint(equalTo: cell.chatLabel.trailingAnchor, constant: 10).isActive = true
        //            view.topAnchor.constraint(equalTo: cell.chatLabel.topAnchor).isActive = true
        //            view.bottomAnchor.constraint(equalTo: cell.chatLabel.bottomAnchor).isActive = true
        //            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        //        }else {
        //            view.translatesAutoresizingMaskIntoConstraints = false
        //            view.leadingAnchor.constraint(equalTo: cell.chatLabel.leadingAnchor, constant: -10).isActive = true
        //            view.topAnchor.constraint(equalTo: cell.chatLabel.topAnchor).isActive = true
        //            view.bottomAnchor.constraint(equalTo: cell.chatLabel.bottomAnchor).isActive = true
        //            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        //        }
        
        return cell
    }
    
    
}

