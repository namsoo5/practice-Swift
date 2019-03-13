//
//  ViewController1.swift
//  prac_PageView
//
//  Created by 남수김 on 13/03/2019.
//  Copyright © 2019 Charang. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var page: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //페이지컨트롤러 위치
        page.currentPage = 0
        // Do any additional setup after loading the view.
    }
}
