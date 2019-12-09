//
//  ViewController.swift
//  prac_Animation
//
//  Created by 남수김 on 2019/11/28.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var hello2Label: UILabel!
    @IBOutlet weak var hello3Label: UILabel!
    
    var animationDuration = 1.5
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        helloLabel.alpha = 0
        hello2Label.alpha = 0
        hello3Label.alpha = 0
        setupGesture()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func setupGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        
        self.flag ? anim2() : anim()
        flag = !flag
        
    }
    
    private func anim(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [.repeat, .autoreverse, .curveLinear], animations: {
            //            self.helloLabel.alpha = 1
            //            self.helloLabel.transform = CGAffineTransform(translationX: -100, y: 0)
            self.helloLabel.transform = CGAffineTransform(rotationAngle: 0.05)
        })
        
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.hello2Label.alpha = 1
            self.hello2Label.transform = CGAffineTransform(translationX: -100, y: 0)
            
        })
        
        UIView.animate(withDuration: animationDuration, delay: animationDuration*2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.hello3Label.alpha = 1
            self.hello3Label.transform = CGAffineTransform(translationX: -100, y: 0)
            
        })
        
        
    }
    
    private func anim2(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveLinear], animations: {
//            self.helloLabel.alpha = 0
            //            self.helloLabel.transform = CGAffineTransform(translationX: -100, y: 0)
            self.helloLabel.transform = .identity
            
        })
        UIView.animate(withDuration: self.animationDuration, delay: self.animationDuration, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.hello2Label.alpha = 0.5
            self.hello2Label.transform = self.hello2Label.transform.translatedBy(x: 0, y: -200)
            .translatedBy(x: 0, y: 100)
            
        })
        
        UIView.animate(withDuration: self.animationDuration, delay: self.animationDuration*2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            self.hello3Label.alpha = 0
            self.hello3Label.transform = .identity
            
        })
    }
}

