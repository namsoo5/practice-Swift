//
//  ViewController.swift
//  prac_Json
//
//  Created by 남수김 on 12/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var friend: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        //asset상의 데이터가져올때 NsDataAsset
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }
        
        do {
            self.friend = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let value: Friend = self.friend[indexPath.row]
        
//        cell.textLabel?.text = value.name + "(\(value.age))"
//        cell.detailTextLabel?.text = value.address_info.city + ", " + value.address_info.country

        cell.textLabel?.text = value.nameAndAge
        cell.detailTextLabel?.text = value.fullAddress
        
        return cell
    }


}

