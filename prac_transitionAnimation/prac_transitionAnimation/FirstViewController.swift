//
//  ViewController.swift
//  prac_transitionAnimation
//
//  Created by 남수김 on 2020/04/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellOriginPoint: CGPoint?
    var cellOriginFrame: CGRect?
    var transition: AnimationTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
     
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController else {
            return
        }
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true)
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        // 좌표계 전환 nil일시 윈도우좌표계
        cellOriginPoint =  cell.superview?.convert(cell.center, to: nil)
        cellOriginFrame =  cell.superview?.convert(cell.frame, to: nil)
        transition = AnimationTransition()
        transition?.setPoint(point: cellOriginPoint)
        transition?.setFrame(frame: cellOriginFrame)
        print(cellOriginPoint)
    }
}

// 화면전환 애니메이션 구현클래스
class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    var originPoint: CGPoint?
    var originFrame: CGRect?
    
    func setPoint(point: CGPoint?) {
        self.originPoint = point
    }
    
    func setFrame(frame: CGRect?) {
        self.originFrame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    // animation될 뷰지정
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        // 다음 보여질뷰 참조
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        // 보여질뷰의 위치잡기
         toView.frame = originFrame!
        // toView.center = originPoint
        // 안보이는 상태로만들기
//        toView.alpha = 0
        // MARK: CGAffineTransform을 이용한 이동효과
//        toView.transform = CGAffineTransform(translationX: 0, y: 50)
        toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        containerView.addSubview(toView)
        // hierarchy on top
        containerView.bringSubviewToFront(toView)
        
        print("containerView")
        print(containerView.frame)
        print("toView")
        print(toView.frame)
        
        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0
        // MARK: 애니메이션 적용
        
        // 뷰의 애니메이션 초기위치 지정
        /* 애니메이션 1
        let originalOriginY = toView.frame.origin.y
        toView.frame.origin.y += 30
        let originSize = toView.frame.size
        toView.frame.size.width -= 100
        toView.frame.size.height -= 100
        */
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            // MARK: 원래자리로 되돌리면서 애니메이션 이동효과
            /* 애니메이션 1
            toView.frame.origin.y = originalOriginY
            toView.frame.size = originSize
             */
            toView.alpha = 1
//            toView.center = containerView.center
            toView.transform = .identity
        }) { _ in
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
            UIView.animate(withDuration: 1) {
                containerView.layoutIfNeeded()
            }
        }
        
        transitionContext.completeTransition(true)
    }
}

extension FirstViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    // present될때 실행애니메이션
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    // dismiss될때 실행애니메이션
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisMissAnim()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // Presenting usually doesn't have any interactivity
        return nil
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    // UINavigationControllerDelegate push/pop 애니메이션
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}


class DisMissAnim: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
        // 사라지는 뷰(종료되는 뷰)
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
//            fromView.frame.origin.y += container.frame.height - fromView.frame.minY
            fromView.alpha = 0
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
}
