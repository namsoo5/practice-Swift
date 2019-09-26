//
//  ViewController.swift
//  prac_Drawing
//
//  Created by 남수김 on 24/09/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastPos = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        self.lastPos = touch.location(in: self.view)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        // 2
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        // 3
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        // 4
        context.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        // 6
        swiped = true
        let currentPos = touch.location(in: view)
        drawLine(from: lastPos, to: currentPos)
        
        // 7
        lastPos = currentPos
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLine(from: lastPos, to: lastPos)
        }
        
        // Merge tempImageView into mainImageView
//        UIGraphicsBeginImageContext(mainImageView.frame.size)
//        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
//        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
//        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
//        tempImageView.image = nil
    }
}

