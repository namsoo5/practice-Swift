//
//  ViewController.swift
//  prac_tableView
//
//  Created by 남수김 on 23/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var datalist = [[String:String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dict1 = ["지역":"한국", "날씨":"비"]
        let dict2 = ["지역":"일본", "날씨":"맑음"]
        let dict3 = ["지역":"중국", "날씨":"눈"]
        let dict4 = ["지역":"스페인", "날씨":"흐림"]
        let dict5 = ["지역":"미국", "날씨":"비"]
        let dict6 = ["지역":"영국", "날씨":"맑음"]
        let dict7 = ["지역":"프랑스", "날씨":"눈"]
        let dict8 = ["지역":"브라질", "날씨":"흐림"]
        let dict9 = ["지역":"덴마크", "날씨":"비"]
        let dict10 = ["지역":"스위스", "날씨":"맑음"]
        let dict11 = ["지역":"벨기에", "날씨":"눈"]
        let dict12 = ["지역":"이탈리아", "날씨":"흐림"]
        let dict13 = ["지역":"네덜란드", "날씨":"비"]
        let dict14 = ["지역":"독일", "날씨":"맑음"]
        let dict15 = ["지역":"필리핀", "날씨":"눈"]
        let dict16 = ["지역":"핀란드", "날씨":"흐림"]
        
        datalist = [dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,dict9,dict10,dict11,dict12,dict13,dict14,dict15,dict16]
        
    }

    //table row개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //withIdentifier 과 storyboard의 tableViewCell의 Identifier의 이름이 같도록 설정하기
        
        
        var dicTemp = datalist[indexPath.row] //한줄한줄채우는작업
        cell.textLabel!.text = dicTemp["지역"]
        
        let weatherStr = dicTemp["날씨"]
        cell.detailTextLabel!.text = weatherStr
        
        if weatherStr == "맑음"{
            cell.imageView!.image = UIImage(named: "<#T##String#>")
        }
    }
    

}

