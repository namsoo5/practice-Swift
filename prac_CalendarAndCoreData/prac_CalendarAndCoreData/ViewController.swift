//
//  ViewController.swift
//  prac_CalendarAndCoreData
//
//  Created by 남수김 on 2020/07/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var count = 0
    private var emptyDayCount = 0
    private let calendar = CalendarCalculate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupMonth()
        collectionView.dataSource = self
        
    }
    
    func setupMonth() {
        
        emptyDayCount = Date.startWeekday(year: "2020", month: "07")-1
        
        count = calendar.getDayOfMonth() + emptyDayCount
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.calendar.nextMonth()
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.calendar.nextMonth()
            }
        }
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DateCollectionViewCell else {
            return .init()
        }
        if indexPath.item > emptyDayCount-1 {
            let day = indexPath.item - emptyDayCount
            cell.dateLabel.text = "\(day+1)"
        } else {
            cell.dateLabel.text = ""
        }
        return cell
    }
}
