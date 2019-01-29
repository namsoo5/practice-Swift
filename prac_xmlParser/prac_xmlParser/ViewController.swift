//
//  ViewController.swift
//  prac_xmlParser
//
//  Created by 남수김 on 28/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, XMLParserDelegate {

    var datalist = [[String:String]]()
    var detaildata = [String:String]()
    var elementTemp:String = ""
    var blank:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/weather.xml"
        
        
        //if문과 비슷하지만 guard는 값이 참이 될때사용하며, 항상 else가 같이따라옴
        guard let baseURL = URL(string: urlString) else {
            print("URL error")
            return
        }
        guard let parser = XMLParser(contentsOf: baseURL) else {
            print("Can't read data")
            return
        }
        
        parser.delegate = self   //delegate 연결
        if !parser.parse(){      //xml parse함수
            print("parse fail")
        }
        
    }
    
    /* xml parse */
    //각태그 시작시호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        /* let test = """
        elementName: \(elementName)
        namespaceURi: \(namespaceURI)
        qualifiedName: \(qName)
        attrivutes: \(attributeDict)
        """
        */
       // print("didStartElemnet: \(test)")
        
        blank = true
        elementTemp = elementName  //시작되는 태그 저장
    }
    
    //각태그사이에 있는 값가져옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
       // print("foundCharacters: \(string)")
        
        if blank && elementTemp != "local" && elementTemp != "weatherinfo" {  //country, weather, temperature만사용
            //whitespace제거
            detaildata[elementTemp] = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //xml태그끝에 빈칸을 인식함 -> 데이터가아닌 빈배열저장되는 문제발생 -> blank 변수로 해결(트리거)
        }
        
    }
    
    //각태그 끝날시호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
       // print("didEndElement: \(elementName)")
    
        if elementName == "local" {
            datalist += [detaildata]
        }
        blank = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        var dicTemp = datalist[indexPath.row]
        
        cell.countryLabel.text = dicTemp["country"]
        let weatherStr = dicTemp["weather"]
        cell.weatherLabel.text = weatherStr
        cell.temperatureLabel.text = dicTemp["temperature"]
        
        if weatherStr == "맑음" {
            cell.imgView.image = UIImage(named: "sunny.png")
        }else if weatherStr == "비" {
            cell.imgView.image = UIImage(named: "rain.png")
        }else if weatherStr == "흐림" {
            cell.imgView.image = UIImage(named: "cloud.png")
        }else if weatherStr == "눈" {
            cell.imgView.image = UIImage(named: "snow.png")
        }
        
        
        return cell
    }


}

