//
//  ViewController.swift
//  prac_neumorphism
//
//  Created by 남수김 on 2020/04/17.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8223536611, green: 0.7899239063, blue: 1, alpha: 1)
        
        button.addShadow(inColor: .white, outColor: .lightGray, to: [.bottom, .right], radius: 10)
        
        

    }
}

extension UIView {
    func addShadow(inColor: UIColor, outColor: UIColor, to edges:[UIRectEdge], radius:CGFloat){
        
        // Set up its frame.
        let viewFrame = self.frame
        for edge in edges{
            let gradientlayer          = CAGradientLayer()
            gradientlayer.colors       = [outColor.cgColor,inColor.cgColor]
            gradientlayer.shadowRadius = radius
            
            switch edge {
            case UIRectEdge.top:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.bottom:
                gradientlayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientlayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientlayer.frame = CGRect(x: 0.0, y: viewFrame.height - gradientlayer.shadowRadius, width: viewFrame.width, height: gradientlayer.shadowRadius)
            case UIRectEdge.left:
                gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.frame = CGRect(x: 0.0, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            case UIRectEdge.right:
                gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientlayer.frame = CGRect(x: viewFrame.width - gradientlayer.shadowRadius, y: 0.0, width: gradientlayer.shadowRadius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientlayer)
        }
    }
}



/*
 extension UIView {
 @discardableResult
 func addNeumorphismShadow(with parent: UIView, dist: CGFloat = 2, blur: CGFloat = 20) -> [UIView] {
 
 guard let backgroundColor = parent.backgroundColor else { return [] }
 let shadowViews = neumorphismShadowViews(parent: parent, color: backgroundColor, dist: dist, blur: blur)
 shadowViews.forEach {
            insertSubview($0, belowSubview: parent)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
        return shadowViews
    }
    
    @discardableResult
    func addSelectNeumorphismShadow(with parent: UIView, dist: CGFloat = 2, blur: CGFloat = 10) -> [UIView] {
        
//        guard let backgroundColor = parent.backgroundColor else { return [] }
        let backgroundColor = #colorLiteral(red: 0.8223536611, green: 0.7899239063, blue: 1, alpha: 1)
        let shadowViews = selectNeumorphismShadowViews(parent: parent, color: backgroundColor, dist: dist, blur: blur)
        
        for (index, view) in shadowViews.enumerated() {
            if index == 0 {
                insertSubview(view, aboveSubview: parent)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
                view.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.9).isActive = true
                view.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.9).isActive = true
            } else {
                insertSubview(view, belowSubview: parent)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
                view.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.9).isActive = true
                view.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.9).isActive = true
            }
            
        }
        return shadowViews
    }
    
    func neumorphismShadowViews(parent: UIView, color: UIColor, dist: CGFloat, blur: CGFloat) -> [UIView] {
        
        let lightShadowView: UIView = {
            let lightView = UIView(frame: parent.frame)
            let lightColor = color.lighterColor(value: 0.28)
            lightView.backgroundColor = color
            lightView.layer.applyShadow(color: lightColor, alpha: 0.5, x: -dist, y: -dist, blur: blur)
            lightView.layer.cornerRadius = parent.layer.cornerRadius
            lightView.layer.maskedCorners = parent.layer.maskedCorners
            return lightView
        }()
        let darkShadowView: UIView = {
            let darkView = UIView(frame: parent.frame)
            let darkColor = color.darkerColor(value: 0.28)
            darkView.backgroundColor = color
            darkView.layer.applyShadow(color: darkColor, alpha: 0.6, x: dist, y: dist, blur: blur)
            darkView.layer.cornerRadius = parent.layer.cornerRadius
            darkView.layer.maskedCorners = parent.layer.maskedCorners
            return darkView
        }()
        return [lightShadowView, darkShadowView]
    }
    
    func selectNeumorphismShadowViews(parent: UIView, color: UIColor, dist: CGFloat, blur: CGFloat) -> [UIView] {
        
        let lightShadowView: UIView = {
            let lightView = UIView(frame: parent.frame)
            let lightColor = color.lighterColor(value: 0.28)
            lightView.backgroundColor = .clear
            lightView.layer.selectApplyShadow(color: lightColor, alpha: 0.5, x: -dist, y: -dist, blur: blur)
            lightView.layer.cornerRadius = parent.layer.cornerRadius
            lightView.layer.maskedCorners = parent.layer.maskedCorners
            return lightView
        }()
        
        let darkShadowView: UIView = {
            let darkView = UIView(frame: parent.frame)
            let darkColor = color.darkerColor(value: 0.7)
            darkView.backgroundColor = .clear
            darkView.layer.selectApplyShadow(color: darkColor, alpha: 0.6, x: dist, y: dist, blur: blur)
            darkView.layer.cornerRadius = parent.layer.cornerRadius
            darkView.layer.maskedCorners = parent.layer.maskedCorners
            return darkView
        }()
        return [lightShadowView, darkShadowView]
    }
    
}

extension CALayer {
    
    func applyShadow(color: UIColor = .black, alpha: Float = 0.5,
                     x: CGFloat = 0, y: CGFloat = 2,
                     blur: CGFloat = 4, spread: CGFloat = 0) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        masksToBounds = false
    }
    
    func selectApplyShadow(color: UIColor = .black, alpha: Float = 0.5,
                     x: CGFloat = 0, y: CGFloat = 2,
                     blur: CGFloat = 4, spread: CGFloat = 0) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: -x, height: -y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        masksToBounds = false
    }
}

extension UIColor {
    func lighterColor(value: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }

        let hsl = hsbToHsl(h: h, s: s, b: b)
        let hsb = hslToHsb(h: hsl.h, s: hsl.s, l: hsl.l + value)

        return UIColor(hue: hsb.h, saturation: hsb.s, brightness: hsb.b, alpha: a)
    }

    
    func darkerColor(value: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        let hsl = hsbToHsl(h: h, s: s, b: b)
        let hsb = hslToHsb(h: hsl.h, s: hsl.s, l: hsl.l - value)
        
        return UIColor(hue: hsb.h, saturation: hsb.s, brightness: hsb.b, alpha: a)
    }
    
    private func hsbToHsl(h: CGFloat, s: CGFloat, b: CGFloat) -> (h: CGFloat, s: CGFloat, l: CGFloat) {

        let newH = h
        var newL = (2.0 - s) * b
        var newS = s * b
        newS /= (newL <= 1.0 ? newL : 2.0 - newL)
        newL /= 2.0
        return (h: newH, s: newS, l: newL)
    }

    private func hslToHsb(h: CGFloat, s: CGFloat, l: CGFloat) -> (h: CGFloat, s: CGFloat, b: CGFloat) {
        let newH = h
        let ll = l * 2.0
        let ss = s * (ll <= 1.0 ? ll : 2.0 - ll)
        let newB = (ll + ss) / 2.0
        let newS = (2.0 * ss) / (ll + ss)
        return (h: newH, s: newS, b: newB)
    }
}

*/
