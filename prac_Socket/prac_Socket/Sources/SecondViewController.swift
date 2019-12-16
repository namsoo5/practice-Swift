//
//  SecondViewController.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/12/14.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import SocketIO
class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textField: UITextField!
    var myChat: [chatType] = []
    var socket: SocketIOClient!

    //키보드 높이를 저장할 변수
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket = SocketIOManager.shared.socket
        bindMsg()
        
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        initGestureRecognizer()
        registerForKeyboardNotifications()

        
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
            let size = CGSize(width: cell.chatLabel.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            // 말풍선 설정
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
            view.frame = CGRect(x: self.view.frame.width - estimatedFrame.width - 40 - 5, y:cell.chatLabel.frame.origin.y - 5 , width: estimatedFrame.width + 20, height: estimatedFrame.height + 10)
            view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 184/255, alpha: 1.0)
            
        }else { //otehr Chat
            cell = tableView.dequeueReusableCell(withIdentifier: "YourCell", for: indexPath) as? ChatTVC
            let size = CGSize(width: cell.chatLabel.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            // 말풍선 설정
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
            view.frame = CGRect(x: cell.frame.origin.x + 30 , y:cell.chatLabel.frame.origin.y-5 , width: estimatedFrame.width + 20, height: estimatedFrame.height + 10)
            view.backgroundColor = UIColor.white
        }
        
        cell.chatLabel.text = msg
        view.layer.cornerRadius = 7
        
        cell.addSubview(view)
        // Label이 가려지지않도록 설정
        cell.sendSubviewToBack(view)
    
        return cell
    }
    
    
}

extension SecondViewController: UIGestureRecognizerDelegate{
    
    //MARK: - 키보드 내리기
    //TextField를 터치했는지 판별
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: textField) ?? false {
            //터치된 뷰가 TextField면 터치를 안한것처럼 이벤트를 주지않고 키보드가 꺼지지 않도록
            return false
        }
        
        return true
    }
    
    //GestureRecognizer 생성
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    //MARK: - 키보드에 따른 뷰의 이동
    // observer생성
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //observer해제
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        //키보드의 동작시간 얻기
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        //키보드의 애니메이션종류 얻기
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        //키보드의 크기 얻기
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        //iOS11이상부터는 노치가 존재하기때문에 safeArea값을 고려해야 함
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        // animation 함수
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
        
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: -self.keyboardHeight)

        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // 원래대로 돌아가도록
            self.bottomView.transform = .identity
            

        })
        
        self.view.layoutIfNeeded()
    }
    
}
