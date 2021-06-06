//
//  ViewController.swift
//  prac_tableviewMoveTest
//
//  Created by 남수김 on 2020/07/08.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "temp")
        
        
    }
    
   
    
    @IBAction func click(_ sender: Any) {
        if !tableview.isEditing {
            tableview.setEditing(true, animated: true)
        } else {
            tableview.setEditing(false, animated: true)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "test"), object: nil)
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
//        guard let cell = tableView.cellForRow(at: indexPath) else {
//            return .none
//        }
        
//        cell.accessoryType = .disclosureIndicator
//
//        if cell.accessoryType == .disclosureIndicator {
//            cell.accessoryType = .none
//        } else {
//            cell.accessoryType = .disclosureIndicator
//        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath)
        print(destinationIndexPath)
    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//           let deleteAction = UIContextualAction(style: .destructive, title: "삭제할기다") { (action, view, success ) in
//           }
//           let config = UISwipeActionsConfiguration(actions: [deleteAction])
//           config.performsFirstActionWithFullSwipe = false
//           return config
//       }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("touch")
//    }
}
