//
//  ViewController.swift
//  prac_CameraImage
//
//  Created by 남수김 on 16/04/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate

{
    @IBOutlet weak var imageView: UIImageView!
    //촬영하거나 포토라이브러리에서 불러온 이미지 저장하는 변수
    var captureImage: UIImage!
    
    //카메라띄우기
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - 카메라동작
    //사진촬영 버튼
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        
        self.present(self.imagePicker, animated: true, completion: nil)
        //모달로 띄워줌
    }
    
    //cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            captureImage = originalImage
            self.imageView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    
}

