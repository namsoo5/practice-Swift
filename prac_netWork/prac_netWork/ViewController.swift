//
//  ViewController.swift
//  prac_netWork
//
//  Created by 남수김 on 09/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friends: [Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let url: URL = URL(string:"https://randomuser.me/api/?results=20&inc=name,email,picture") else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //에러시
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            //json 받아오기
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friends = apiResponse.results
                
                //main스레드
                DispatchQueue.main.async {
                    self.tableView.reloadData() //메인에서 구현해야함
                }
                
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        
        //dataTask 실행
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Model = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil //재사용시 이전사진이보일수있음
        
        DispatchQueue.global().async { // 백그라운드 아무데서나 동작하는 기본적인것
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else {
                return
            }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else {
                return
            }
            
            //스크롤도중이면 인덱스위치가 변할수있음
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                         cell.imageView?.image = UIImage(data: imageData)
                    }
                }
                
            }
        }
        
       
        return cell
    }


}

