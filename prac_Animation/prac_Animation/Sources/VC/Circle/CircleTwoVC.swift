//
//  CircleTwoVC.swift
//  prac_Animation
//
//  Created by 남수김 on 2019/12/08.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class CircleTwoVC: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
    }

    @IBAction func dismissClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
