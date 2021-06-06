//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    var view1: UIView!
    var view2: UIView!
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    func makeView(superView: UIView, color: UIColor, frame: CGRect) -> UIView {
        let newView = UIView()
        newView.backgroundColor = color
        newView.frame = frame
        
        superView.addSubview(newView)
        return newView
    }
    
    override func viewDidLoad() {
        view1 = makeView(superView: self.view,
                         color: .orange,
                         frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        view2 = makeView(superView: view1,
//                         color: .brown,
//                         frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
//        view1.bounds = CGRect(x: 0, y: 50, width: 200, height: 200)
        view1.transform = CGAffineTransform(rotationAngle: .pi/4)
        makeView(superView: self.view, color: .lightGray, frame: view1.frame)
        
        view.bringSubviewToFront(view1)
        
        print(":::view1 정보:::")
//        print("frame: \(view1.frame)")
        print("bounds: \(view1.bounds)")
        print(":::view2 정보:::")
//        print("frame: \(view2.frame)")
//        print("bounds: \(view2.bounds)")
    }
}
// Present the view controller in the Live View window
let vc = MyViewController()
PlaygroundPage.current.liveView = vc




