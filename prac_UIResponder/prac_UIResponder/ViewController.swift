//
//  ViewController.swift
//  prac_UIResponder
//
//  Created by 남수김 on 2020/11/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view1 = AView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        view.addSubview(view1)
        let view2 = BView(frame: CGRect(x: 50, y: 100, width: 150, height: 150))
        view1.addSubview(view2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(":::::touch:::::::")
        print(touches.first?.view)
    }
}

class AView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("A Touch")
    }
}

class BView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("B Touch")
    }
}
