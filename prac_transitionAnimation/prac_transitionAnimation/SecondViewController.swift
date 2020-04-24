//
//  SecondViewController.swift
//  prac_transitionAnimation
//
//  Created by 남수김 on 2020/04/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.dismiss(animated: true)
        }
    }
}

extension SecondViewController: UIViewControllerTransitioningDelegate {
}
