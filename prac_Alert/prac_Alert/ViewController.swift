//
//  ViewController.swift
//  prac_Alert
//
//  Created by 남수김 on 09/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func touchShowAlertbt(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    @IBAction func touchShowActionbt(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet
        )
    }
    
    //Alert setting - actionSheet or alert
    func showAlertController(style: UIAlertController.Style){
        
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        //default style
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in
            // textField값 받아오기
            // alert일때만 textfield가존재하므로
              if style == UIAlertController.Style.alert {
                print("\(alertController.textFields?[0].text! ?? "")")
            }
        })
        
        //cancel stytle
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) -> Void
        handler = {(action: UIAlertAction) in
          
            print("action pressed \(action.title ?? "")")
        
        }
        
        //destructive style
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: UIAlertAction.Style.destructive, handler: handler)
        
        alertController.addAction(someAction)
        
        //textfield
        if style == UIAlertController.Style.alert {
            alertController.addTextField(configurationHandler: {(field: UITextField) in
                field.placeholder = "placeholder"
                field.textColor = UIColor.red
            })
        }
        
        self.present(alertController, animated: true, completion: {
            print("alert shown")
        })
        
    }
}

