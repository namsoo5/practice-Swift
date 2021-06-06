//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var label: UILabel!
    var button: UIButton!
    var color: UIColor = .black {
        didSet {
            view.layoutIfNeeded()
        }
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        
        button = UIButton()
        button.frame = CGRect(x: 150, y: 400, width: 200, height: 20)
        button.backgroundColor = .black
        button.setTitle("change", for: .normal)
        button.addTarget(self,
                         action: #selector(self.clickButton),
                         for: .touchUpInside)
        
        view.addSubview(button)
        
        self.view = view
    }
    
    @objc
    func clickButton() {
        label?.text = "hihihi"
        color = .blue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(":::::::::::::::::")
        print("::::::start::::::")
        print(":::::::::::::::::")
//        excuteLayoutIfNeeded()
//        excuteSetNeedsLayout()
    }
    
    override func updateViewConstraints() {
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        print(#function)
        print(view.frame)
        label?.textColor = color
    }
    
    override func viewDidLayoutSubviews() {
        print(view.frame)
        print(#function)
    }
    
    func excuteLayoutIfNeeded() {
        print("excute:: layoutIfNeeded")
        view.layoutIfNeeded()
        
    }
    
    func excuteSetNeedsLayout() {
        print("excute:: setNeedsLayout")
        view.setNeedsLayout()
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

