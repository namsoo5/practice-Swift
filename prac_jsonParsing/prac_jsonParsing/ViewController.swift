import UIKit

struct Weather:Decodable {  //Decodable을 상속받아야 jsondecoder가 인식가능
    let country:String
    let weather:String
    let temperature:String
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var datalist = [Weather]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let jsonURLString = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/swift4weather.json"
        
        guard let jsonURL = URL(string: jsonURLString) else {return}
        
        //URLSession객체리턴, 
        URLSession.shared.dataTask(with: jsonURL, completionHandler: {(data, response, error) -> Void in
            guard let data = data else{return}
            
            do{
                //class.self 은 class의 type을 리턴받는다
                self.datalist = try JSONDecoder().decode([Weather].self, from: data)
                // decode함수형식에 throws가 잇으므로 catch해줘야함
               // print(self.datalist)
                //비동기통신
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    })
            }catch {
                print("error: \(error)")
            }
            
        }).resume()
    }
    //json은 잘넘어오지만 파싱하는 과정은 비동기이므로 백그라운드에서 돌아간다.
    //따라서 데이터를 받고있는 중에 테이블이 만들어지면서 테이블에 제대로된 데이터가 들어가지않는다.
    // 그냥 self.tableView.reloadData()를 쓰면 백그라운드에서 메인UI를 건들수없도록 되어있기때문에 오류가발생한다
    //DispatchQueue 사용
    // 안의코드를 비동기적으로 수행하며 작업완료시 main thread queue를 호출해서 작업수행

    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        let structTemp = datalist[indexPath.row]
        
        cell.countryLabel.text = structTemp.country
        let weatherStr = structTemp.weather
        cell.weatherLabel.text = weatherStr
        cell.temperatureLabel.text = structTemp.temperature
        
        if weatherStr == "맑음" {
            cell.imgView.image = UIImage(named: "sunny.png")
        }else if weatherStr == "비" {
            cell.imgView.image = UIImage(named: "rain.png")
        }else if weatherStr == "흐림" {
            cell.imgView.image = UIImage(named: "cloud.png")
        }else if weatherStr == "눈" {
            cell.imgView.image = UIImage(named: "snow.png")
        }else {
            cell.imgView.image = UIImage(named: "snow.png")
        }
        
        return cell
    }
}

