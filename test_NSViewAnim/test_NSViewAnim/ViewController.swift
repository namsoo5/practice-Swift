//
//  ViewController.swift
//  test_NSViewAnim
//
//  Created by 남수김 on 2019/12/11.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import NSViewAnim
class ViewController: UIViewController, NSDownView {
    func downViewControllerEvent(_ gesture: UIPanGestureRecognizer) {
        downViewController(gesture)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downScrollDismissAnim()
    }


}

