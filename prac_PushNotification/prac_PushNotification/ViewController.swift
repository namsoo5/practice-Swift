//
//  ViewController.swift
//  prac_PushNotification
//
//  Created by 남수김 on 2020/02/26.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        let attributedString = NSMutableAttributedString(string: testLabel.text!, attributes: [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
          .kern: -0.01
            ])
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .medium), range: (testLabel.text! as NSString).range(of: "마바사"))
        attributedString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.2196078431, green: 0.1333333333, blue: 0.4862745098, alpha: 1), range: (testLabel.text! as NSString).range(of: "마바사"))
        
        self.testLabel.attributedText = attributedString
    }

    @IBAction func pushClick(_ sender: Any) {
        let push =  UNMutableNotificationContent()

        push.title = "test Title"
        push.subtitle = "test subTitle"
        push.body = "test body"
        push.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: push, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        tokenLabel.text = delegate.DeviceToken
    }
    
}

