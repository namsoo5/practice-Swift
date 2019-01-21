//
//  ViewController.swift
//  prac_SignUpForm
//
//  Created by 남수김 on 20/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var blogTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        nameTextField.delegate = self
        emailTextField.delegate = self //일일이다해줘야함... 아니면
        디자인영역에서 오른쪽클릭에 delegate를 드래그해서viewController에 적용해도됨
        */
    }

    @IBAction func signUpAction(_ sender: Any) {
        outputTextView.text = "\(nameTextField.text!)님 가입을 축하합니다."
    }
    
    //delegate이용
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  //리턴키누르면
        /*
        nameTextField.resignFirstResponder()  //키보드창내리기
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        telTextField.resignFirstResponder()
        blogTextField.resignFirstResponder()
        
        하나하나 해주면 너무김 파라미터받아온것 이용하기
         */
        textField.resignFirstResponder()
        return true
    }
    
    //상위클래스에있는 터치이벤트함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)  //화면터치시 키보드내려감
    }
    
}

