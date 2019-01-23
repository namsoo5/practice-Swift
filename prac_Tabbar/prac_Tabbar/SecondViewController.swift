//
//  SecondViewController.swift
//  prac_Tabbar
//
//  Created by 남수김 on 22/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        outputLabel.text = "2번 버튼이 눌렸습니다"
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
