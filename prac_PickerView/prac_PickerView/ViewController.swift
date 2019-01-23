//
//  ViewController.swift
//  prac_PickerView
//
//  Created by 남수김 on 22/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //delegate, datasource 연결하기 ->하드코딩또는 스토리보드 오른쪽버튼

    @IBOutlet weak var imageView: UIImageView!
    
    /*component1*/
    let seasonName = ["spring", "summer", "fall", "winter"]
    
    var season = [String]()  //seasonName에 대한 목록들
    var seasonImage = [String]()  //imageview loading
    //같은표현 var seasonImage:[String] = []
    
    /*component2*/
    let spring = ["spring1","spring2","spring3"]
    let summer = ["summer1","summer2","summer3","summer4"]
    let fall = ["fall1","fall2","fall3","fall4"]
    let winter = ["winter1","winter2","winter3"]
    
    
    /*images array*/
    let springImages = ["spring1.jpg","spring2.jpg","spring3.jpg"]
    let summerImages = ["summer1.jpg","summer2.jpg","summer3.jpg","summer4.jpg"]
    let fallImages = ["fall1.jpg","fall2.jpg","fall3.png","fall4.jpg"]
    let winterImages = ["winter1.jpg","winter2.jpg","winter3.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        season = spring
        seasonImage = springImages //처음상태초기화
        
        imageView.layer.cornerRadius = 50.0 //imageview 둥근정도설정
        imageView.layer.masksToBounds = true //처리결과 보이게해줌
    }
    
    //uipickerviewdatasource의 required함수
    //component의 개수지정함수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2  //2개 (column)
    }
    //uipickerviewdatasource의 required함수
    //각 컴포넌트에대한 row개수지정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //컴포넌트 0 일때... 1 일때...
        if component == 0 {
            return seasonName.count
        }else{
            return season.count
        }
    }
    
    //UIPickerViewDelegate required함수중하나
    //데이터 설정 (텍스트 넣어주는기능)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //각 컴포넌트 0일때 row 0, 1, 2....
        //컴포넌트 1일때 row 0, 1, 2...
        if component == 0 {
            return seasonName[row]
        }else{
            return season[row]
        }
    }
    
    //delegate
    //값선택에따른 이벤트
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 && row == 0{
            season = spring
            seasonImage = springImages
        }else if component == 0 && row == 1{
            season = summer
            seasonImage = summerImages
        }else if component == 0 && row == 2{
            season = fall
            seasonImage = fallImages
        }else if component == 0 && row == 3{
            season = winter
            seasonImage = winterImages
        }
        
        pickerView.reloadAllComponents() //갱신시켜줘야 적용됨
        imageView.image = UIImage(named: seasonImage[pickerView.selectedRow(inComponent: 1)]) //해당컴포넌트 값에따른인덱스를 받아서 이미지변경
    }

}

