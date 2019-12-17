//
//  ChatTVC.swift
//  prac_Socket
//
//  Created by 남수김 on 2019/12/15.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatTVC: UITableViewCell {
    
    @IBOutlet weak var chatLabel: UILabel!
    var msg: String! {
        willSet {
            self.chatLabel.text = newValue
        }
    }
    var estimatedFrame: CGRect!
    var bubbleView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(bubbleView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
