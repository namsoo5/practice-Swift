//
//  MenuTableViewController.swift
//  
//
//  Created by 남수김 on 20/03/2019.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuList = ["메뉴1","메뉴2","메뉴3"]  //메뉴list
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            print(menuList.count)
            return menuList.count
        default:
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 1{
            let cell:InfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! InfoTableViewCell
            
            cell.nameLabel.text = "김남수"
            cell.phoneLabel.text = "010-1234-5678"
            tableView.rowHeight = 100
            cell.backgroundColor = UIColor.init(red: 1.0, green: 0.5, blue: 0.5, alpha: 0.2)
            
            return cell
        } else {
            let cell:MenuListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menulist", for: indexPath) as! MenuListTableViewCell
            
            tableView.rowHeight = 50
            cell.menuLabel.text = menuList[indexPath.row]
            cell.backgroundColor = UIColor.lightGray
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)선택!")
        if indexPath.section == 1 {   //섹션1이 메뉴리스트에 해당
            switch indexPath.row {
                //각 행에맞는 메뉴클릭시
            case 0:
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu1") else {
                    print("not found...")
                    return}
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                return
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
