//
//  SecondViewController.swift
//  prac_Animation
//
//  Created by 남수김 on 2019/12/03.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var transitionLabel: UILabel!
    @IBOutlet weak var presentationLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var trans = 0
    var present = 0
    var transSet: [UIModalTransitionStyle] = [.coverVertical, .crossDissolve, .flipHorizontal, .partialCurl]
    
    var presentSet: [UIModalPresentationStyle] = [.currentContext, .fullScreen, .overCurrentContext, .overFullScreen, .formSheet, .pageSheet, .popover]
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func nextVCButtonClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") else {return}
        
        nextVC.modalPresentationStyle = presentSet[present]
        nextVC.modalTransitionStyle = transSet[trans]
        
        nextVC.view.alpha = 0.5
        
        self.present(nextVC, animated: true)
    }
    
    @IBAction func stepClick(_ sender: UIStepper) {
        
        switch segment.selectedSegmentIndex {
        case 0:
            trans  = Int(sender.value)
            if trans > 3{
                trans = 3
            }
            if trans < 0{
                trans = 0
            }
            transitionLabel.text = "\(trans)"
        case 1:
            present  = Int(sender.value)
            
            if present > 6{
                present = 6
            }
            if present < 0{
                present = 0
            }
            presentationLabel.text = "\(present)"
        default:
            return
        }
    }
}
