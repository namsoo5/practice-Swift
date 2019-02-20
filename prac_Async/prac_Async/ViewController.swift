//
//  ViewController.swift
//  prac_Async
//
//  Created by 남수김 on 17/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func downloadButton(_ sender: Any) {
        //이미지 다운로드 -> 이미지 뷰에 셋팅
        //https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg
        
        
        let imageURL: URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg")!

        
        // 아래와같은 방식일경우 다운받는동안 아무것도 할수없다
//        let imageData: Data = try! Data.init(contentsOf: imageURL)  //동기메소드 -> 완료전까지 다음으로넘어가지않음
//        let image: UIImage = UIImage(data: imageData)!
//        self.imageView.image = image
        
        
        OperationQueue().addOperation { //쓰레드만들어서 백그라운드작업
            let imageData: Data = try! Data.init(contentsOf: imageURL)  //동기메소드 -> 완료전까지 다음으로넘어가지않음
            let image: UIImage = UIImage(data: imageData)!
            
            OperationQueue.main.addOperation {  // 메인 쓰레드로가져와서 실행
                self.imageView.image = image
            }
            
        }
    }
}

