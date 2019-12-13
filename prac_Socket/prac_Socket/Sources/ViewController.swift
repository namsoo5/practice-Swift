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
        
        
       
    }
    
   
    @IBAction func disconnetSocket(_ sender: Any) {
        SocketIOManager.shared.closeConnection()
    }
    @IBAction func connectSocket(_ sender: Any) {
        SocketIOManager.shared.establishConnection()
    }
    
    @IBAction func sendData(_ sender: Any) {
        SocketIOManager.shared.sendMessage(message: "hihi", withNickname: "ns")
    }
    
    
}

