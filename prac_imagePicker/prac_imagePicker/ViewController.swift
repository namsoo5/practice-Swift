//
//  ViewController.swift
//  prac_imagePicker
//
//  Created by 남수김 on 05/02/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //picker를 쓰기위해서 2개의 delegate를 상속받아야함
    
    @IBOutlet weak var imgView: UIImageView!
    
    //lazy - 해당 코드가 실행될때 실행하는 문법
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func bt_selectPhoto(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
        //모달로 띄워줌
    }
    
    //cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        //창닫아줌
    }
    
    //select photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }
}

