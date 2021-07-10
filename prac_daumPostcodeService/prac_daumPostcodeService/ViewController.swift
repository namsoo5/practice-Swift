//
//  ViewController.swift
//  prac_daumPostcodeService
//
//  Created by 남수김 on 2021/07/10.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView()
    }

    func webView() {
        guard let htmlFileURL = Bundle.main.path(forResource: "postcode", ofType: "html") else {
            return
        }
        let gitURL = URL(string: "https://namsoo5.github.io/pracPostcode")!
        let url = gitURL
        let request = URLRequest(url: url)
        let configure = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        configure.userContentController = contentController
        
        let webview = WKWebView(frame: UIScreen.main.bounds, configuration: configure)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        webview.load(request)
        view.addSubview(webview)
    }
}

extension ViewController: WKNavigationDelegate {
    
}

extension ViewController: WKUIDelegate {
    //alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        self.present(alertController, animated: true, completion: nil) }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }
        return nil }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("✅✅✅✅✅")
        print(message.name)
        if let data = message.body as? [String: Any] {
            print(data["address"])
            print(data["bcode"])
        }
        
    }
}
