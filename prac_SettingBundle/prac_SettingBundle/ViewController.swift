//
//  ViewController.swift
//  prac_SettingBundle
//
//  Created by 남수김 on 2020/08/26.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("b", forKey: "test")
        
        
        if UserDefaults.standard.bool(forKey: "isBlack") {
            view.backgroundColor = .gray
        } else {
            view.backgroundColor = .white
        }
    }


}

