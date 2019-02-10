//
//  ViewController.swift
//  prac_tableView2
//
//  Created by 남수김 on 10/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellidentifier: String = "Cell"
    let customCellIdentifier: String = "customCell"
    let korean: [String] = ["가","나","다","라","마","바","사","아","자","차","카","타","파","하"]
    let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var dates: [Date] = []
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        // formatter.timeStyle = .medium
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tableView.delegate = self
        //        self.tableView.dataSource = self
        
        
    }
    
    //섹션수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //섹션당 테이블의 행설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  //0번 섹션
            return korean.count
        case 1:  //1번 섹션
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    //행에해당하는 cell내용 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section < 2{
            //재사용가능한 셀을 꺼내온다
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellidentifier, for: indexPath)
            
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            return cell
        }else {
            //cell 선택
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
            
            //cell 값설정
            cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            return cell
        }
        
        
    }
    
    //헤더설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        }
        return nil
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        dates.append(Date())
        //단순 추가
        //self.tableView.reloadData()
        
        //애니메이션과함께 추가
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }
    
}

