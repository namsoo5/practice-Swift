//
//  TabPageCollectionViewCell.swift
//  prac_TabBarAnimation
//
//  Created by 남수김 on 2020/04/29.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class TabPageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabPageCell"
    lazy var backColor: [UIColor] = [.lightGray, .purple, .orange, .cyan, .magenta]
    
    func setColor(index: Int){
        self.backgroundColor = backColor[index]
    }
}
