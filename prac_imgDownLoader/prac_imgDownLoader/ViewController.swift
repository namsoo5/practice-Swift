//
//  ViewController.swift
//  prac_imgDownLoader
//
//  Created by 남수김 on 28/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var downloadTask:URLSessionDownloadTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //closure 이아닌 delegate시에만 progress를 보여줄수있음
    //delegate함수
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //bytesWritten  현재 전송용량
        //totalBytesWritten  누적 전송용량
        //totalBytesExpectedToWrite  전체 용량
        let progress:Float = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        progressbar.setProgress(progress, animated: true)
        print(totalBytesWritten)
    }
    
    //다운끝날시 ,required함수
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let dataTemp:Data = try! Data(contentsOf: location)  //url로받은 객체 data형태로 변환
        self.imgView.image = UIImage(data: dataTemp)  //이미지뷰에 이미지넣기
        indicator.stopAnimating()
    }
    
    
    @IBAction func DownButton(_ sender: Any) {
        
        /* Closure 이용하는방법 */
        imgView.image = nil
        indicator.startAnimating()
        progressbar.setProgress(0.0, animated: false)
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)//main queue, delegate사용
        
        //DownloadTask 생성방법이 다름
        //delegate 사용시 아래코드
        //downloadTask = session.downloadTask(with: URL(string: "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!)
        
        /* Closure 사용 */
        downloadTask = session.downloadTask(with: URL(string: "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!, completionHandler: {(data, response, error) -> Void in
            
            if data != nil { //url로받은 객체 data형태로 변환
                let dataTemp:Data = try! Data(contentsOf: data!)
                self.imgView.image = UIImage(data: dataTemp)  //이미지뷰에 이미지넣기
                self.indicator.stopAnimating()
            }
            
            
        })
        downloadTask.resume() //다운시작
        
        
        /* delegate 사용
         
         imgView.image = nil
         indicator.startAnimating()
         progressbar.setProgress(0.0, animated: false)
         let sessionConfiguration = URLSessionConfiguration.default
         let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)//main queue, delegate사용
         downloadTask = session.downloadTask(with: URL(string: "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!)
         downloadTask.resume() //다운시작
         */
    }
    
    @IBAction func SuspendButton(_ sender: Any) {
        downloadTask.suspend()
    }
    @IBAction func ResumeButton(_ sender: Any) {
        downloadTask.resume()
    }
    @IBAction func CancelButton(_ sender: Any) {
        downloadTask.cancel()
        indicator.stopAnimating()
        progressbar.setProgress(0.0, animated: false)
        
    }
}

