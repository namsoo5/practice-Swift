//
//  ViewController.swift
//  prac_containerView
//
//  Created by 남수김 on 13/03/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var first: UIView!
    
    @IBOutlet weak var second: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }

    
    //화면전환효과
    @IBAction func next(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.first.alpha = 0.0
            self.second.alpha = 1.0
            print("app: \(Data1.shared.textdata)")
            //정보를 보내줌
            request()
            
            
        })
        
    }
    
    @IBAction func before(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.first.alpha = 1.0
            self.second.alpha = 0.0
              request()
            
    
            
            
        })
    }
}

