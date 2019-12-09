//
//  ThirdViewController.swift
//  prac_Animation
//
//  Created by 남수김 on 2019/12/03.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureAction = UIPanGestureRecognizer(target: self, action: #selector(downViewControllerEvent))
        
        self.view.addGestureRecognizer(gestureAction)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


extension ThirdViewController {
    
    @objc func downViewControllerEvent(_ gesture: UIPanGestureRecognizer){
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if windowScene.interfaceOrientation.isPortrait {
                let trans = gesture.translation(in: self.view)
                if trans.y > 0 {
                    self.view.transform = CGAffineTransform(translationX: 0, y: trans.y)
                }
                
                if gesture.state == .ended {
                    //   1/3지점까지는 원위치로
                    if self.view.frame.midY < self.view.frame.height * 2/3 {
                        self.view.transform = .identity
                    }else{
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
}
