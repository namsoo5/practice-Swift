//
//  ViewController.swift
//  prac_CustomCell
//
//  Created by 남수김 on 24/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var itemlist = [[String:String]]()  //딕셔너리배열
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let item1 = ["name":"사과","image":"사과.jpg","amount":"6","value":"3000원"]
        let item2 = ["name":"딸기","image":"딸기.jpg","amount":"10","value":"2000원"]
        let item3 = ["name":"라임","image":"라임.jpg","amount":"4","value":"5000원"]
        let item4 = ["name":"레몬","image":"레몬.jpg","amount":"11","value":"4000원"]
        let item5 = ["name":"바나나","image":"바나나.jpg","amount":"19","value":"4000원"]
        let item6 = ["name":"블루베리","image":"블루베리.jpg","amount":"20","value":"10000원"]
        let item7 = ["name":"오렌지","image":"오렌지.jpg","amount":"5","value":"3500원"]
        let item8 = ["name":"키위","image":"키위.jpeg","amount":"8","value":"2500원"]
        let item9 = ["name":"파인애플","image":"파인애플.jpg","amount":"7","value":"6000원"]
        let item10 = ["name":"포도","image":"포도.jpg","amount":"13","value":"7000원"]
        
        itemlist = [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        //사용자가만든 클래스로 강제형변환

        let dicTemp = itemlist[indexPath.row]
       
        cell.nameLabel.text = dicTemp["name"]
        cell.amountLabel.text = "\(dicTemp["amount"]!)개"
        cell.valueLabel.text = dicTemp["value"]
        cell.imgView.image = UIImage(named: dicTemp["image"]!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //넘어갈때 자동으로 호출되는 콜백메소드
        if segue.identifier == "showDetail" {
            (segue.destination as! DetailViewController).detaildata = itemlist[tableView.indexPathForSelectedRow!.row]//선택된 row의값 넘어감
        }
    }
    
    
    
}

