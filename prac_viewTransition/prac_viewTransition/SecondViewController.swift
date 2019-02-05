//
//  SecondViewController.swift
//  prac_viewTransition
//
//  Created by 남수김 on 05/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //화면이 나타나기전에 설정함
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = UserInfo.shared.name
        self.ageLabel.text = UserInfo.shared.age
    }
    
    
    
    @IBAction func pop(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissmodal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
