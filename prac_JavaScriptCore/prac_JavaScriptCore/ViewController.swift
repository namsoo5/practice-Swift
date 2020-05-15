//
//  ViewController.swift
//  prac_JavaScriptCore
//
//  Created by 남수김 on 2020/05/15.
//  Copyright © 2020 남수김. All rights reserved.
//
import JavaScriptCore
import UIKit

class ViewController: UIViewController {
    let context = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJS()
        firstTest()
        jsDemo1()
        jsDemo3()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buildUI()
    }
    
    // MARK: ex1
    func firstTest() {
        // 자바스크립트에서 돌릴수있도록 오브젝트추가
        // 넣을 클래스, forKeyedSubscript: 스크립트코드내에서 사용할 타입명
        context?.setObject(TestA.self, forKeyedSubscript: "TestA" as (NSCopying & NSObjectProtocol))
        
        //evaluateScript:  자바스크립트 코드실행
        let jsValue1 = context?.evaluateScript(
            """
    (function(){
    var test = TestA.getInstance();
    return test.hello()})()
    """
        )
        
        let jsValue2 = context?.evaluateScript(
            """
    (function(){
    var test = TestA.getInstance();
    return test.yourName('ns')
    })()
    """
        )
        
        // MARK: ex2
        // 자바스크립트 내에서 변수를 objectForKeyedSubscript를 통해서 가져올 수있음
        // 자바스크립트는 함수또한 변수로 저장할 수 있으므로 함수도 가져올수 있음
        let givenJavaScriptFunction =
"""
function(a,b) {
return a+b;
}
"""
        let namedFunction = "var sum1 = " + givenJavaScriptFunction
        context?.evaluateScript(namedFunction)
        let sumFunc = context?.objectForKeyedSubscript("sum1")
        let result = sumFunc?.call(withArguments: [10,7])
        
        
        print(result?.toDouble())
        print(jsValue1!)
        print(jsValue2!)
    }
    
    func fetchJS() {
        if let jsSourcePath = Bundle.main.path(forResource: "pracJSCore", ofType: "js") {
            do {
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                self.context?.evaluateScript(jsSourceContents)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func jsDemo1() {
        let firstname = "Mickey"
        let lastname = "Mouse"
     
        if let functionFullname = self.context?.objectForKeyedSubscript("getFullname") {
            if let fullname = functionFullname.call(withArguments: [firstname, lastname]) {
                print(fullname.toString())
            }
        }
    }
    //convention -> swift 메소드의구현
    let luckyNumbersHandler: @convention(block) ([Int]) -> Void = { luckyNumbers in
        print(luckyNumbers)
    }
    
    func jsDemo3() {
        // JSExport -> objc 클래스 제작
        // unsafeBitCast -> swift 콜백함수
        let luckyNumbersObject = unsafeBitCast(self.luckyNumbersHandler, to: AnyObject.self)
        // 함수luckyNumbersHandler를 자바스크립트에 handleLuckyNumbers로 넣어주기
        self.context?.setObject(luckyNumbersObject, forKeyedSubscript: "handleLuckyNumbers" as (NSCopying & NSObjectProtocol))
        
        if let functionGenerateLuckyNumbers = self.context?.objectForKeyedSubscript("generateLuckyNumbers") {
            // 자바스크립트 코드에서 handleLuckyNumbers 호출함
            // call: 자바스크립트 함수실행
            _ = functionGenerateLuckyNumbers.call(withArguments: nil)
        }
    }
    
    func buildUI() {
        if let UI = context?.objectForKeyedSubscript("UIElements")?.toArray() {
            UI.forEach {
                switch $0 as! String {
                case "Label":
                    generateLabel()
                case "Alert":
                    if let alertInfo = context?.objectForKeyedSubscript("alert")?.toDictionary() {
                        guard let style = alertInfo["style"] as? String,
                            let title = alertInfo["title"] as? String else {
                                return
                        }
                        let alertStyle: UIAlertController.Style = style == "alert" ? .alert : .actionSheet
                        generateAlert(style: alertStyle, title: title)
                    }
                    
                default:
                    print("...???")
                }
            }
        }
    }
    
    func generateAlert(style: UIAlertController.Style, title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: style)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
       
    func generateLabel() {
        if let count = context?.objectForKeyedSubscript("labelCount")?.toNumber() {
            for i in 1..<Int(truncating: count)+1 {
                let key = "label\(i)"
                if let frame = context?.objectForKeyedSubscript(key)?.toDictionary() {
                    guard let x = frame["x"] as? CGFloat,
                        let y = frame["y"] as? CGFloat,
                        let width = frame["width"] as? CGFloat,
                        let height = frame["height"] as? CGFloat,
                        let text = frame["text"] as? String else {
                            return
                    }

                    let rect = CGRect(x: x, y: y, width: width, height: height)
                    let label = UILabel(frame: rect)
                    label.text = text
                    DispatchQueue.main.async {
                        self.view.addSubview(label)
                    }
                }
            }
        }
    }
    
    func nextVC() {
        let VC = UIViewController()
        VC.view.backgroundColor = .purple
        
        present(VC, animated: true)
    }
}

@objc protocol TestJSExports: JSExport {
    func hello() -> String
    func yourName(_ name: String) -> String
    static func getInstance() -> TestA
}

class TestA: NSObject, TestJSExports {
    public func hello() -> String {
        return "Hello World!"
    }
    
    public func yourName(_ name: String) -> String {
        return "Hello, " + name + "!"
    }
    
    class func getInstance() -> TestA {
        return TestA()
    }
}
