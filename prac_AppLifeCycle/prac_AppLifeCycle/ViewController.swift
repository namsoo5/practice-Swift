//
//  ViewController.swift
//  prac_AppLifeCycle
//
//  Created by 남수김 on 21/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //수동적인 뷰를 만들때, 하드코딩으로 뷰를 만들때
//    override func loadView() {
////        super.loadView() // super쓰면안된다고 써있는데 안쓰면 뷰가 안보임
//        print("loadview")
//    }
    
    override func viewWillAppear(_ animated: Bool) {  //view가 바뀔때마다 호출
        print("willappear")
    }
    override func viewDidAppear(_ animated: Bool) {
    print("didappear")
    }
    override func viewWillDisappear(_ animated: Bool) {  //사라질거다
        print("willdisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {   //사라졌다
        print("diddisappear")
    }
    override func viewDidLoad() {   //메모리에 추가됬을때
        super.viewDidLoad()
        print("viewdidload")
        // Do any additional setup after loading the view, typically from a nib.
    }


}

