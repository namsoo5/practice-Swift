//
//  ViewController.swift
//  prac_Shadow
//
//  Created by 남수김 on 2021/07/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curveShadow()
    }
    
    func shadow() {
        topView.layer.shadowColor = UIColor.red.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowRadius = 1
        topView.layer.shadowOffset = CGSize(width: 10, height: 10)
        topView.layer.shadowPath = nil
    }
    
    func customShadow() {
        let size: CGFloat = 20
        let distance: CGFloat = 0
        let rect = CGRect(
            x: -size,
            y: topView.frame.height - (size * 0.4) + distance,
            width: topView.frame.width + size * 2,
            height: size
        )

        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowRadius = 1
        topView.layer.shadowOpacity = 1
        topView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
    }
    
    func shadowPath() {
        let scale = CGSize(width: 1.25, height: 0.5)
        let offsetX: CGFloat = 0

        let shadowPath = UIBezierPath()
        shadowPath.move(to:
            CGPoint(
                x: 0,
                y: topView.frame.height
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width,
                y: topView.frame.height
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width * scale.width + offsetX,
                y: topView.frame.height * (1 + scale.height)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width * (1 - scale.width) + offsetX,
                y: topView.frame.height * (1 + scale.height)
            )
        )
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowRadius = 1
        topView.layer.shadowOpacity = 1
        topView.layer.shadowPath = shadowPath.cgPath
    }
    
    func shadowPath3D() {
        let scale = CGSize(width: 1.5, height: 1.5)
        let offset = CGPoint(x: topView.frame.width, y: -topView.frame.height)

        let shadowPath = UIBezierPath()
        shadowPath.move(to:
            CGPoint(
                x: 0,
                y: topView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == 1 ? 0 : offset.y)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width,
                y: topView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == -1 ? 0 : offset.y)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width * scale.width + offset.x,
                y: topView.frame.height * (1 + scale.height) + offset.y
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: topView.frame.width * (1 - scale.width) + offset.x,
                y: topView.frame.height * (1 + scale.height) + offset.y
            )
        )
        topView.layer.shadowPath = shadowPath.cgPath
        topView.layer.shadowRadius = 0
        topView.layer.shadowOffset = .zero
        topView.layer.shadowOpacity = 0.2
        topView.layer.shadowColor = UIColor.black.cgColor
    }
    
    func curveShadow() {
        let curve: CGFloat = 100

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint.zero)
        shadowPath.addLine(to: CGPoint(
            x: topView.frame.width,
            y: 0
        ))
        shadowPath.addLine(to: CGPoint(
            x: topView.frame.width,
            y: topView.frame.height + curve
        ))
        shadowPath.addCurve(
            to: CGPoint(
                x: 0,
                y: topView.frame.height + curve
            ),
            controlPoint1: CGPoint(
                x: topView.frame.width,
                y: topView.frame.height
            ),
            controlPoint2: CGPoint(
                x: 0,
                y: topView.frame.height
            )
        )
        topView.layer.shadowPath = shadowPath.cgPath
        topView.layer.shadowRadius = 10
        topView.layer.shadowOffset = CGSize(width: 0, height: 10)
        topView.layer.shadowOpacity = 0.5
        topView.layer.shadowColor = UIColor.black.cgColor
    }
    @IBAction func slide(_ sender: UISlider) {
        if sender.tag == 0 {
            topView.layer.shadowRadius = CGFloat(sender.value)
        } else {
            topView.layer.shadowOpacity = sender.value
        }
    }
}

