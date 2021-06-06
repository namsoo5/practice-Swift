//
//  ViewController.swift
//  prac_TableViewDistinguish
//
//  Created by 남수김 on 2020/11/25.
//

import UIKit

class ViewController: UIViewController {
    var table1: UITableView!
    var table2: UITableView!
    
    let aDataSource = ATableController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table1 = makeTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        table2 = makeTableView(frame: CGRect(x: 0, y: 250, width: 375, height: 200))
        view.addSubview(table1)
        view.addSubview(table2)
        
        table1.dataSource = aDataSource
        table1.delegate = aDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.aDataSource.num = 5
            self.table1.reloadData()
        }
        
    }

    
    func makeTableView(frame: CGRect) -> UITableView {
        let tableView = UITableView(frame: frame)
        tableView.dataSource = self
        return tableView
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .brown
        return cell
    }
}

class ATableController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var num = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .red
        return cell
    }
    
}
