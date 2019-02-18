//
//  ViewController.swift
//  prac_CollectionView
//
//  Created by 남수김 on 18/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //var numberOfCell: Int = 10
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIentifier: String = "cell"
    var friends:[Friend] = []
    
    @IBAction func btclick(_ sender: Any) {
        //공유할아이템3개
        let imageToShare: UIImage? = UIImage(named: "ch")
        let urlToShare: String = "https://www.google.co.kr"
        let textToShare: String = "hi, google"
        
        // 공유아이템지정
        let activityViewController = UIActivityViewController(activityItems: [imageToShare!, urlToShare, textToShare], applicationActivities: nil)
        
        //사용하지않을 타입
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.airDrop]
        
        //컨트롤러 나타내기
        self.present(activityViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero  //margin제거
        flowLayout.minimumInteritemSpacing = 10 //같은행에 있는 item 간격 10이상
        flowLayout.minimumLineSpacing = 10  //line 간격 10이상
        
        let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
        //화면에 2개씩 나타내기위함
        
        flowLayout.estimatedItemSize = CGSize(width: halfWidth-30, height: 90)
        //예상 사이즈
        
        self.collectionView.collectionViewLayout = flowLayout //flowlayou적용
        
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name:"friends") else {
            return
        }
        do {
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        }catch{
            print(error.localizedDescription)
        }
        
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:FriendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIentifier, for: indexPath) as? FriendCollectionViewCell else {
            print("cell error")
            return UICollectionViewCell()
        }
        
        let friend:Friend = friends[indexPath.item]  //item은 테이블뷰의 row에해당하는것
        
        cell.nameAgeLabel.text = friend.nameAndAge
        cell.addressLabel.text = friend.fullAddress
        
        return cell
    }
    
    //item 선택시
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.numberOfCell += 1
//        collectionView.reloadData()
//    }
    
    


}

