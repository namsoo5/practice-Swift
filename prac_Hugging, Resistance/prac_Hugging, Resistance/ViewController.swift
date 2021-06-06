//
//  ViewController.swift
//  prac_Hugging, Resistance
//
//  Created by 남수김 on 2020/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    lazy var aView = UIView()
    lazy var bView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(leftLabel.intrinsicContentSize)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("-----")
        print(leftLabel.intrinsicContentSize)
        print(leftLabel.frame)
        
        let origin = leftLabel.frame.origin
        leftLabel.frame = CGRect(origin: origin, size: CGSize(width: 30, height: 50))
        print("변경후")
    
        print(leftLabel.intrinsicContentSize)
        print(leftLabel.frame)
        leftLabel.invalidateIntrinsicContentSize()
        
        leftLabel.isHidden = true
        rightLabel.isHidden = true
        layout()
    }
    
    func layout() {
        view.addSubview(aView)
        view.addSubview(bView)
        aView.translatesAutoresizingMaskIntoConstraints = false
        bView.translatesAutoresizingMaskIntoConstraints = false
        aView.backgroundColor = .blue
        bView.backgroundColor = .red
        
        // Visual Format
        let views: [String : Any] = ["a": aView,
                                     "b": bView]
        let format1 = "H:|-8-[a]-8-|"
        let format2 = "H:|-30-[b]-30-|"
        let format3 = "V:|-20-[a(100)]"
        let format4 = "V:[a]-20-[b(100)]"

        var constraint = NSLayoutConstraint.constraints(withVisualFormat: format1,
                                                        options: [],
                                                        metrics: nil,
                                                        views: views)
        constraint += NSLayoutConstraint.constraints(withVisualFormat: format2,
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        constraint += NSLayoutConstraint.constraints(withVisualFormat: format3,
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        constraint += NSLayoutConstraint.constraints(withVisualFormat: format4,
                                                     options: [],
                                                     metrics: nil,
                                                     views: views)
        view.addConstraints(constraint)
        
//         NSLayoutConstraint
//         파란뷰
        NSLayoutConstraint.init(item: aView,
                                attribute: .leading,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .leading,
                                multiplier: 1.0,
                                constant: 8).isActive = true
        NSLayoutConstraint.init(item: aView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .top,
                                multiplier: 1.0,
                                constant: 20).isActive = true
        NSLayoutConstraint.init(item: aView,
                                attribute: .trailing,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .trailing,
                                multiplier: 1.0,
                                constant: -8).isActive = true
        NSLayoutConstraint.init(item: aView,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .height,
                                multiplier: 1.0,
                                constant: 100).isActive = true

        // 빨간뷰
        NSLayoutConstraint.init(item: bView,
                                attribute: .leading,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .leading,
                                multiplier: 1.0,
                                constant: 30).isActive = true
        NSLayoutConstraint.init(item: bView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: aView,
                                attribute: .bottom,
                                multiplier: 1.0,
                                constant: 20).isActive = true
        NSLayoutConstraint.init(item: bView,
                                attribute: .trailing,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .trailing,
                                multiplier: 1.0,
                                constant: -30).isActive = true
        NSLayoutConstraint.init(item: bView,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: nil,
                                attribute: .height,
                                multiplier: 1.0,
                                constant: 100).isActive = true
        
        
//                 NSLayoutAnchor
        aView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8).isActive = true
        aView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true
        aView.topAnchor.constraint(equalTo: view.topAnchor,constant: 20).isActive = true
        aView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        bView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        bView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        bView.topAnchor.constraint(equalTo: aView.bottomAnchor,constant: 20).isActive = true
        bView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

