//
//  TabBarCollectionViewCell.swift
//  prac_TabBarAnimation
//
//  Created by 남수김 on 2020/04/28.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabBarCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                titleLabel.textColor = .black
            } else {
                titleLabel.textColor = .lightGray
            }
        }
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
}
