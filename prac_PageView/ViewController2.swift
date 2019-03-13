//
//  ViewController2.swift
//  prac_PageView
//
//  Created by 남수김 on 13/03/2019.
//  Copyright © 2019 Charang. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var page: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        page.currentPage = 1
        
        // Do any additional setup after loading the view.
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
