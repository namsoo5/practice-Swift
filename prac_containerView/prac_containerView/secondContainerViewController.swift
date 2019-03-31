//
//  secondContainerViewController.swift
//  prac_containerView
//
//  Created by 남수김 on 13/03/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class secondContainerViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification받을것이다
        NotificationCenter.default.addObserver(self, selector: #selector(self.changelabel(_:)) , name: DidReceiveFriendsNotification, object: nil)
        //DidReceiveFriendsNotification 발생시 didRecieveFriendsNotification실행
        
    }
    

    @objc func changelabel(_ noti: Notification){
        DispatchQueue.main.async {
            self.label.text = Data1.shared.textdata
            print("성공")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        Data1.shared.textdata = textfield1.text
        print("second: \(Data1.shared.textdata!)")
        

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
