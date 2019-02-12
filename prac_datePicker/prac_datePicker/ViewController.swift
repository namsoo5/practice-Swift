//
//  ViewController.swift
//  prac_datePicker
//
//  Created by 남수김 on 05/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateStyleLabel: UILabel!
    @IBOutlet weak var timeStyleLabel: UILabel!
    //사용자 정의format사용
    let dateformatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        //formatter.dateStyle = .medium  // MM(영문) DD, YY 날짜형식
        //formatter.timeStyle = .medium  // at h:mm:ss a 시간형식
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss" //사용자 지정형식
        return formatter
    }()
    
    //dateStyle사용
    let dateformatter2: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") //한국시간,  en_US:미국시간대
        formatter.dateStyle = .full  // MM(영문/한글) DD, YY 날짜형식
        //formatter.timeStyle = .medium  // at h:mm:ss a 시간형식
        //formatter.dateFormat = "yyyy/MM/dd hh:mm:ss" //사용자 지정형식
        return formatter
    }()
    
    //timeStyle사용
    let dateformatter3: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        //formatter.dateStyle = .medium  // MM(영문) DD, YY 날짜형식
        formatter.timeStyle = .medium  // at h:mm:ss a 시간형식
        //formatter.dateFormat = "yyyy/MM/dd hh:mm:ss" //사용자 지정형식
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  인터페이스빌더에서 event를 처리하는것을 코드로 나타냄
         - datpicker의 값변경시 함수호출하도록 설정
         self.datePicker.addTarget(self, action: #selector(self.datePickerValueChange(_:)), for: UIControl.Event.valueChanged)
         */
    }
    
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        
        let date: Date = sender.date
        let dateString: String = self.dateformatter.string(from: date)
        let dateString2: String = self.dateformatter2.string(from: date)
        let dateString3: String = self.dateformatter3.string(from: date)
        self.dateLabel.text = "dateString: \(dateString)"
        self.dateStyleLabel.text = "dateStyle: \(dateString2)"
        self.timeStyleLabel.text = "timeStyle: \(dateString3)"
        
        
    }
    
}

