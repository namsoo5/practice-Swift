//
//  ViewController.swift
//  prac_subView
//
//  Created by 남수김 on 04/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: view.center.x-100, y: 100, width: 200, height: 200)
        //x:0, y:0위치는 왼쪽상단이고 뷰의 좌표 기준점은 뷰의 왼쪽상단이다
        //따라서 중앙값을 x값으로준다음 너비의 반을 빼줘야 중앙에 위치한다.
    
        let subView = UIView(frame: frame) //뷰생성
        
        subView.backgroundColor = UIColor.cyan
        subView.layer.cornerRadius = 100
        
        print("frame: \(subView.frame)") //슈퍼좌표계를 기준으로 해당뷰의 좌표와 크기나타냄
        print("bounds: \(subView.bounds)")  //자신의 좌표계를 기준으로 해당 뷰의 위치와 크기 나타냄
        print("frame origin: \(subView.frame.origin)")  //origin값은 좌표만 나타냄
        print("bounds origin: \(subView.bounds.origin)")
        print("frame size: \(subView.frame.size)") //size는 너비와 높이나타냄
        print("bounds size: \(subView.bounds.size)")
        
        view.addSubview(subView)  //subView추가
        
        //subView.removeFromSuperview()
        //서브뷰 제거
    }
}

