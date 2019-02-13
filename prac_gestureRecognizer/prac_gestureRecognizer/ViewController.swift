//
//  ViewController.swift
//  prac_gestureRecognizer
//
//  Created by 남수김 on 05/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    //방법1 인터페이스빌더사용
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true) //키보드내리기
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //방법2 인터페이스빌더를 사용하지않고 코드로구현하기 & delegate사용
/*
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        self.view.addGestureRecognizer(tapGesture)
         

        //터치시 실행됨
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            self.view.endEditing(true)
            return true
        }
*/
        
    }


}

