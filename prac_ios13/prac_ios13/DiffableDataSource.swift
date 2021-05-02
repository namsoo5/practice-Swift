//
//  DiffableDataSource.swift
//  prac_ios13
//
//  Created by 남수김 on 2021/05/01.
//

import UIKit


class DiffableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Int, UUID>!
    private var colors: [UIColor] = [.red, .orange, .cyan, .green, .blue, .brown, .darkGray, .purple]
    private var section = 0
    @IBOutlet private weak var isSection: UISwitch!
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        
        dataSource = UITableViewDiffableDataSource<Int, UUID>(tableView: tableView) { (tableView, indexPath, uuid) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.backgroundColor = self.colors[indexPath.row % self.colors.count]
            print(indexPath)
            return cell
        }
        
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
        
        // 빈 snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()

        snapshot.appendSections([section])
        section += 1
        snapshot.appendItems([UUID(),UUID(),UUID()])
        dataSource.apply(snapshot)
    }
    
    @IBAction func append(_ sender: Any) {
        // 현재상태 snapshot 복사
        var curSnapshot = dataSource.snapshot()
        
        if isSection.isOn {
            curSnapshot.appendSections([section])
            // 아이템 넣어줘야 Cell이 증가함
            curSnapshot.appendItems([UUID()])
            section += 1
        } else {
            curSnapshot.appendItems([UUID()])
        }
        dataSource.apply(curSnapshot)
        
    }
    
    @IBAction func deleteSnapshot(_ sender: Any) {
        // 현재상태 snapshot 복사
        var curSnapshot = dataSource.snapshot()
        if isSection.isOn {
            section -= 1
            // Section 전체삭제
            curSnapshot.deleteSections([section])
        } else {
            if let lastItem = curSnapshot.itemIdentifiers.last {
                // Cell 하나삭제
                curSnapshot.deleteItems([lastItem])
            }
        }
        dataSource.apply(curSnapshot)
    }
    
    @IBAction func insert(_ sender: Any) {
        // 현재상태 snapshot 복사
        var curSnapshot = dataSource.snapshot()
        
        if isSection.isOn {
            curSnapshot.insertSections([section], afterSection: 0)
            section += 1
        } else {
            if let first = curSnapshot.itemIdentifiers.first {
                curSnapshot.insertItems([UUID()], afterItem: first)
            }
        }
        dataSource.apply(curSnapshot)
    }
}
