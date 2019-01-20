//
//  ViewController.swift
//  prac_VisualBookManager
//
//  Created by 남수김 on 17/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myBookManager = BookManager()   //new class
    
    //ui control
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var countLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let book1 = Book(name: "햄릿", genre: "비극", author: "셰익스피어")
        let book2 = Book(name: "누구를 위하여 종을 울리나", genre: "전쟁", author: "헤밍웨이")
        let book3 = Book(name: "죄와벌", genre: "사실주의", author: "톨스토이")
        
        myBookManager.registerBook(bookObject: book1)
        myBookManager.registerBook(bookObject: book2)
        myBookManager.registerBook(bookObject: book3) //책등록
        
        countLable.text = "\(myBookManager.countBooks())"
    }
    
    
    @IBAction func showAllAction(_ sender: Any){
//        print("showAllAction")
        outputTextView.text = myBookManager.showAllBook()
    }
    
    @IBAction func registerAction(_ sender: Any){
        var bookTemp = Book()
        
        bookTemp.name = nameTextField.text!
        bookTemp.author = authorTextField.text!
        bookTemp.genre = genreTextField.text!
        
        myBookManager.registerBook(bookObject: bookTemp)
        outputTextView.text = "\(nameTextField.text!) has been registered."
        countLable.text = "\(myBookManager.countBooks())"
    }

    @IBAction func searchAction(_ sender: Any){
//        let resultBook = myBookManager.searchBook(name: nameTextField.text!)
//        if(resultBook != nil){
//            outputTextView.text = resultBook
//        }else{
//            outputTextView.text = "not found book"
//        }
//         아래코드는 바인딩옵셔널 이용
        if let resultBook = myBookManager.searchBook(name: nameTextField.text!){
            outputTextView.text = resultBook
        }else{
            outputTextView.text = "not found book"
        }
    }

    @IBAction func removeAction(_ sender: Any){
        myBookManager.removeBook(name: nameTextField.text!)
        outputTextView.text = "\(nameTextField.text!) removed"
        countLable.text = "\(myBookManager.countBooks())"
    }
}

