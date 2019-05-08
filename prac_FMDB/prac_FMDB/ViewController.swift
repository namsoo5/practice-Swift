//
//  ViewController.swift
//  prac_FMDB
//
//  Created by 남수김 on 29/04/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import FMDB
class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func saveBt(_ sender: Any) {
        let fileURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("user.sqlite")
        let database = FMDatabase(url: fileURL)
        
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do {
            let input:String = textfield.text ?? " "
            try database.executeUpdate("create table if not exists test(x text, y int, z text)", values: nil)
            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["\(input)", 3, "input"])
            try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["하이", 1, "루"])
            
            let rs = try database.executeQuery("select x, y, z from test", values: nil)
            while rs.next() {
                if let x = rs.string(forColumn: "x"), let y = rs.string(forColumn: "y"), let z = rs.string(forColumn: "z") {
                    print("x = \(x); y = \(y); z = \(z)")
                    textView.text.append("x:\(x) y:\(y) z:\(z)")
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        database.close()
    }
    

}

