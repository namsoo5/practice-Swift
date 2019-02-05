//
//  ViewController.swift
//  prac_viewTransition
//
//  Created by 남수김 on 05/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func bt_setData(_ sender: Any) {
        UserInfo.shared.name = nameText.text
        UserInfo.shared.age = ageText.text
    }
    
}

