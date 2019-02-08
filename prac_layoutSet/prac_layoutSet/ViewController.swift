//
//  ViewController.swift
//  prac_layoutSet
//
//  Created by 남수김 on 03/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bt: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        // 오토레이아웃 사용시 false해주기 충돌날수잇음
        
        var constraintX: NSLayoutConstraint
        constraintX = bt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        //centerXAnchor : horizontal center
        //bt의 centerXAnchor위치를 view의 centerXAnchor로 적용
        
        var constraintY: NSLayoutConstraint
        constraintY = bt.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        constraintX.isActive = true
        constraintY.isActive = true  //생성된 제약 적용
        
        label.translatesAutoresizingMaskIntoConstraints = false
        //오토레이아웃 사용시 false
        
        var LabelConstraintX: NSLayoutConstraint
        LabelConstraintX = label.centerXAnchor.constraint(equalTo: bt.centerXAnchor)
        
        var LabelConstraintY: NSLayoutConstraint
        LabelConstraintY = label.bottomAnchor.constraint(equalTo: bt.topAnchor, constant: -10)
        //constant기준점으로부터 이동거리
        //-값이 위로 움직임
        
        LabelConstraintX.isActive = true
        LabelConstraintY.isActive = true
        
        
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        var widthConstraint: NSLayoutConstraint
        widthConstraint = label2.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 2.0)
        
        var Label2Y: NSLayoutConstraint
        Label2Y = label2.topAnchor.constraint(equalTo: bt.bottomAnchor, constant: 10)
        
        var Label2X: NSLayoutConstraint
        Label2X = label2.centerXAnchor.constraint(equalTo: bt.centerXAnchor)
        
        label2.backgroundColor = UIColor.purple
        label.backgroundColor = UIColor.cyan
        
        widthConstraint.isActive = true
        Label2X.isActive = true
        Label2Y.isActive = true
    }


}

