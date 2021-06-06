//
//  ViewController.swift
//  prac_CountDownLabel
//
//  Created by 남수김 on 2021/02/11.
//

import UIKit

class ViewController: UIViewController {
    var stackView: UIStackView!
    var labels: [CountScrollLabel] = []
    var label: CountScrollLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setStackView()
        setLabel()
        
    }
    
    @IBAction func click(_ sender: Any) {
//        for i in labels.indices {
//            labels[i].clean()
//            labels[i].animate()
//        }

        label.animate(ascending: true)
    }
    
    func setStackView() {
        stackView = {
            $0.clipsToBounds = true
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 150).isActive = true
            return $0
        }(UIStackView())
    }
    
//    func setLabel() {
//        for i in 0..<4 {
//            let label = CountPushLabel()
//            label.config(num: i, cycle: i)
//            labels.append(label)
//            stackView.addArrangedSubview(label)
//        }
//    }
    
    func setLabel() {
        label = CountScrollLabel()
        label.config(num: "0123", duration: 0.5)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}

class CountPushLabel: UILabel, CAAnimationDelegate {
    var originCycle: Int!
    var cycle: Int! // 앞보다 늦게끝나기위한 프로퍼티
    var originNum: Int = 0
    var curNum: Int = 0 {
        didSet {
            if curNum > 9 {
                cycle -= 1
                curNum = 0
            }
        }
    }
    var duration: TimeInterval!
    
    func config(num: Int, cycle: Int, duration: TimeInterval = 0.1) {
        self.originCycle = cycle
        self.cycle = cycle
        self.originNum = num
        self.curNum = num
        self.duration = duration
        self.text = "\(num)"
        self.font = .boldSystemFont(ofSize: 20)
    }
    
    func animate() {
        curNum += 1
        self.text = "\(curNum)"
        pushAnimate()
    }
    
    private func pushAnimate() {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        transition.delegate = self
        self.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if curNum == originNum && cycle < 0 {
            self.layer.removeAllAnimations()
            return
        }
        animate()
    }
    
    func clean() {
        config(num: originNum, cycle: originCycle)
    }
}


class CountScrollLabel: UILabel {
    private var scrollLayers: [CAScrollLayer] = []
    private var labels: [UILabel] = []
    private var duration: TimeInterval = 0
    private var originText: String = ""
    
    func config(num: String, duration: TimeInterval) {
        originText = num
        self.duration = duration
        setupLabel(numString: num)
    }
    
    // 가로로 각각 레이블 생성
    func setupLabel(numString: String) {
        let numArr = numString.map { String($0) }
        var x: CGFloat = 0
        let y: CGFloat = 0
        
        numArr.forEach {
            let label = UILabel()
            label.frame.origin = CGPoint(x: x, y: y)
            label.text = "0"
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.sizeToFit()
            createScrollLayer(label: label, num: Int($0)!)
            x += label.bounds.width
        }
    }
    
    // 각각의 레이블에 대해서 세로로 스크롤레이어 추가
    func createScrollLayer(label: UILabel, num: Int) {
        let scrollLayer = CAScrollLayer()
        scrollLayer.frame = label.frame
        scrollLayers.append(scrollLayer)
        self.layer.addSublayer(scrollLayer)
        
        makeScrollContent(num: num, scrollLayer: scrollLayer)
    }
    
    // 각각의 레이블의 스크롤레이어에 스크를된 콘텐츠 레이블추가
    func makeScrollContent(num: Int, scrollLayer: CAScrollLayer) {
        
        var numSet: [Int] = [0]
        for i in num...num+10 {
            let contentNum = i > 9 ? i % 10 : i
            numSet.append(contentNum)
        }
        
        var height: CGFloat = 0
        for i in numSet {
            let label = UILabel()
            label.text = "\(i)"
            label.font = .boldSystemFont(ofSize: 20)
            label.frame = .init(x: 0,
                                y: height,
                                width: scrollLayer.frame.width,
                                height: scrollLayer.frame.height)
            label.sizeToFit()
            scrollLayer.addSublayer(label.layer)
            labels.append(label) // 저장안하면 해제되서 사라지는 이슈주의
            height = label.frame.maxY
        }
    }
    
    func animate(ascending: Bool) {
        var offset: TimeInterval = 0.0 // 각 자리마다 시간차를 주기위함
        for scrollLayer in scrollLayers {
            let maxY = scrollLayer.sublayers?.last?.frame.origin.y ?? 0
            let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            animation.duration = duration + offset
            animation.timingFunction = .init(name: .easeOut)
            
            if ascending {
                animation.toValue = 0
                animation.fromValue = maxY
            } else {
                animation.toValue = maxY
                animation.fromValue = 0
            }
            
            scrollLayer.scrollMode = .vertically
            scrollLayer.add(animation, forKey: nil)
            scrollLayer.scroll(to: CGPoint(x: 0, y: maxY))
            
            offset += 0.4
        }
    }
}
