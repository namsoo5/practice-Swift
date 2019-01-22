//
//  ViewController.swift
//  prac_flightBook
//
//  Created by 남수김 on 21/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var departureDateButton: UIButton!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var returnDateButton: UIButton!
    @IBOutlet weak var selectDatePicker: UIDatePicker!
    
    var buttonTag:Int = 1  //button 태그구별하기위함
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnDateLabel.isHidden = true
        returnDateButton.isHidden = true //ui 숨기기
        selectDatePicker.isHidden = true
        
    }

    @IBAction func showDatePickerAction(_ sender: UIButton) {//departuredate button
        if selectDatePicker.isHidden == false {
            selectDatePicker.isHidden = true
        }else{
            selectDatePicker.isHidden = false
        }
        
        buttonTag = sender.tag  //버튼의 태그저장
    }
//    @IBAction func showReturnDateAction(_ sender: Any) { //스위치이벤트
    // print(sender.description)할경우 UISwitch 오브젝트가 넘어옴
    @IBAction func showReturnDateAction(_ sender: UISwitch) { //uiswitch형으로 받아옴
     
/*
         방법1
        if returnDateButton.isHidden == false {
            returnDateButton.isHidden = true
            returnDateLabel.isHidden = true
        }else{
            returnDateButton.isHidden = false
            returnDateLabel.isHidden = false
        }
 */
/*
         방법2
        if (sender as! UISwitch).isOn {  //형변환
            returnDateButton.isHidden = false
            returnDateLabel.isHidden = false  //보이기
        }else{
            returnDateButton.isHidden = true
            returnDateLabel.isHidden = true
        }
*/
        //sender를 UISwitch형으로 받았기때문에 형변환필요없는 간결한 코드
        returnDateButton.isHidden = !sender.isOn
        returnDateLabel.isHidden = !sender.isOn
    }
    @IBAction func selectedDateAction(_ sender: UIDatePicker) { //datepicker
        let format = DateFormatter()
        format.dateFormat = "YY-MM-dd hh:mma"
        let dateString = format.string(from: sender.date)  //date형식을 string으로 변환
        if buttonTag == 1 {
            departureDateButton.setTitle("\(dateString)", for: UIControl.State.normal)
        }else {
            returnDateButton.setTitle("\(dateString)", for: UIControl.State.normal)
        }
        
    }
    
    //화면터치시
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)  //키보드 내리기
        selectDatePicker.isHidden = true  //사라지게
    }
}

