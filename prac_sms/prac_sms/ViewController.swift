//
//  ViewController.swift
//  prac_sms
//
//  Created by 남수김 on 18/03/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import MessageUI
class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    //메시지 보낸후 실행
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case MessageComposeResult.cancelled:
            print("cancel")
        case MessageComposeResult.sent:
            print("send")
        case MessageComposeResult.failed:
            print("fail")
        default:
            print("why...?")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: Any) {
        
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        if MFMessageComposeViewController.canSendText(){
            messageComposer.recipients = ["01000000000"]
            messageComposer.body = "hi"
            self.present(messageComposer, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}

