//
//  ViewController.swift
//  prac_CustomView
//
//  Created by 남수김 on 2020/11/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView2 = CustomView2(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 200))
        
        view.addSubview(customView2)
    }
}

