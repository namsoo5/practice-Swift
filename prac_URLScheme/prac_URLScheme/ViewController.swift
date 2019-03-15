
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func sms(_ sender: Any) {
       
        let stringUrl = "sms://01012341234"
        guard let carUrl = URL(string: stringUrl) else { return }
        
        //url 유효성 검사
        if UIApplication.shared.canOpenURL(carUrl) {
            print("can url")
            //해당 url를 내장앱으로 열어준다
            UIApplication.shared.open(carUrl, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func google(_ sender: Any) {
        let stringUrl = "https://www.google.co.kr"
        guard let carUrl = URL(string: stringUrl) else { return }
        
        //url 유효성 검사
        if UIApplication.shared.canOpenURL(carUrl) {
            print("can url")
            //해당 url를 내장앱으로 열어준다
            UIApplication.shared.open(carUrl, options: [:], completionHandler: nil)
        }
    }
    

}

