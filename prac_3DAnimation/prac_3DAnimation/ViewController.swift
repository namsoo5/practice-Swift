//
//  ViewController.swift
//  prac_3DAnimation
//
//  Created by 남수김 on 2020/06/12.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMockView()
      
    }
    
}


/*
 var perspective = CATransform3DIdentity
 var testView: UIView!
 
        testView = UIView(frame: CGRect(x: -150, y: -150, width: 300, height: 150))
        testView.backgroundColor = .blue
        perspective.m34 = -1 / 500
        
        let transformLayer = CATransformLayer()
        transformLayer.transform = perspective
        transformLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        transformLayer.addSublayer(testView.layer)
        view.layer.addSublayer(transformLayer)
        
//        testView.layer.transform = CATransform3DMakeRotation(-0.5, 1, 0, 0)
        
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = CATransform3DMakeRotation(0.5, 1, 0, 1)
        anim.toValue = CATransform3DMakeRotation(-0.5, 1, 0, 1)
        anim.duration = 2
        anim.autoreverses = true
        anim.repeatCount = 5
        testView.layer.add(anim, forKey: "transform")
        
        */
