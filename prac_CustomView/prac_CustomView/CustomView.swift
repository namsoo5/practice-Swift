//
//  CustomView.swift
//  prac_CustomView
//
//  Created by 남수김 on 2020/11/12.
//

import UIKit

class CustomView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
        loadView()
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("CustomView",
                                       owner: self,
                                       options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
}


class CustomView2: UIView {
    
    override class func awakeFromNib() {
        print("awake")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
        loadView()
    }
    
    private func loadView() {
        let purpleView = makeView()
        purpleView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 30)
        addSubview(purpleView)
        
        let label = makeLabel()
        label.frame = CGRect(x: 0, y: 50, width: bounds.width, height: 20)
        addSubview(label)
    }
    
    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "커스텀2"
        label.textAlignment = .center
        return label
    }
}

