//
//  ViewController.swift
//  prac_digitalFrame
//
//  Created by 남수김 on 19/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView! //속성을변경할때 IBOutlet
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cuteImages = [UIImage(named:"1.jpg")!,   //이미지파일불러오기
                          UIImage(named:"2.jpg")!,
                          UIImage(named:"3.jpg")!,
                          UIImage(named:"4.jpeg")!,
                          UIImage(named:"5.jpeg")!,
                          UIImage(named:"6.jpeg")!,
                          UIImage(named:"7.jpeg")!,
                          UIImage(named:"8.jpg")!,
                          UIImage(named:"9.jpg")!]
        imgView.animationImages = cuteImages //이미지 뷰에 이미지저장
        imgView.animationDuration = 9.0 //double형
        speedLabel.text = String(format: "%.2f", slider.value)//소수 2째자리까지 format이용
        
    }
    
    @IBAction func toggleButton(_ sender: Any){
        
        if(imgView.isAnimating){  //이미지전환중이라면
            imgView.stopAnimating()
            toggleButton.setTitle("Start", for: UIControl.State.normal)
        }else{
            imgView.animationDuration = Double(slider.value) //slider값가져오기 duration값이바뀌면 멈춤
            imgView.startAnimating() //이미지전환
            toggleButton.setTitle("Stop", for: UIControl.State.normal)
        }
    }
    
    @IBAction func SliderSpeed(_ sender: Any){
        imgView.animationDuration = Double(slider.value) //slider값가져오기 duration값이바뀌면 멈춤
        imgView.startAnimating() //이미지전환
        toggleButton.setTitle("Stop", for: UIControl.State.normal)
        speedLabel.text = String(format: "%.2f", slider.value)//소수 2째자리까지 format이용
    }
    


}

