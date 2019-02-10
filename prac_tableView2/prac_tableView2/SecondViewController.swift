//
//  SecondViewController.swift
//  prac_tableView2
//
//  Created by 남수김 on 10/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var textToSet: String?
    
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.textLabel.text = self.textToSet
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
