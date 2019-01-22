//
//  ViewController.swift
//  prac_MiniBrowser
//
//  Created by 남수김 on 21/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit
import WebKit //WKWebView

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate{
    //WKNavigationDelegate: webview의 진행상황에 따른 처리가능
    @IBOutlet weak var bookMarkSegmentedCtrl: UISegmentedControl!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var spinningActivityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let initialURL = "https://www.facebook.com"
        let myURL = URL(string:initialURL)
        let myRequest = URLRequest(url:myURL!)
        mainWebView.load(myRequest)     //웹실행
        urlTextField.text = initialURL  //주소창 초기화
        
        mainWebView.navigationDelegate = self  //delegate 설정
        
    }
    //웹로딩시작시 호출
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinningActivityIndicator.startAnimating()  //진행표시창 애니메이션시작
    }
    
    //웹로딩끝날시 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinningActivityIndicator.stopAnimating()
    }

    @IBAction func bookMarkAction(_ sender: Any) {
        //bookMarkSegmentedCtrl.titleForSegment  해당인덱스의 타이틀반환
        //bookMarkSegmentedCtrl.selectedSegmentIndex  해당 인덱스반환
        let bookMarkURL = bookMarkSegmentedCtrl.titleForSegment(at: bookMarkSegmentedCtrl.selectedSegmentIndex)
        //버튼의 이름을 가져와서 해당url로이동
        let urlString = "https://www.\(bookMarkURL!).com"
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        urlTextField.text = urlString
        
    }

    //delegate 엔터키입력시
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var urlString = "\(urlTextField.text!)"
        if !urlString.hasPrefix("https://"){ //앞에https://가없다면
            //hasprefix: 접두사, hassuffix: 접미사
            urlString = "https://\(urlTextField.text!)"
        }
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        urlTextField.text = urlString
        textField.resignFirstResponder()  //키보드내리기
        return true
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        mainWebView.goBack()
    }
    
    @IBAction func goForwardAction(_ sender: Any) {
        mainWebView.goForward()
    }
    
    @IBAction func stopLoadingAction(_ sender: Any) {
        mainWebView.stopLoading()
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        mainWebView.reload()
    }
}

