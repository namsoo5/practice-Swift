//
//  TestTableViewCell.swift
//  prac_tableviewMoveTest
//
//  Created by 남수김 on 2020/07/09.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeButton), name: Notification.Name("test"), object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc
    func changeButton() {
        UIView.animate(withDuration: 0.3) {
            if self.accessoryType == .disclosureIndicator {
                self.accessoryType = .none
            } else {
                self.accessoryType = .disclosureIndicator
            }
        }
    }
    
    deinit {
        print("deinit")
    }
}
