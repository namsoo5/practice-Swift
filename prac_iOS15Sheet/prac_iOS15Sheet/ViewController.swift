//
//  ViewController.swift
//  prac_iOS15Sheet
//
//  Created by 남수김 on 2021/06/28.
//

import UIKit

class ViewController: UIViewController {

    private var curSheet: UISheetPresentationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curSheet = self.presentationController as? UISheetPresentationController
    }

    @IBAction func clickButton(_ sender: Any) {
        setPicker()
//        presentScrollView()
    }
    
    @IBAction func downClick(_ sender: Any) {
        curSheet?.animateChanges {
            curSheet?.selectedDetentIdentifier = .medium
        }
    }
    
    func setPicker() {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") else {
            return
        }
        nextVC.view.backgroundColor = [.systemPurple, .green, .blue].randomElement()!
        if let sheet = nextVC.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()] // 크기 설정
            sheet.smallestUndimmedDetentIdentifier = .medium // medium 디밍뷰 제거
            sheet.prefersGrabberVisible = true // 손잡이
        }
        present(nextVC, animated: true)
    }
    
    func presentScrollView() {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "Scroll") else {
            return
        }
        
        if let sheet = nextVC.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 스크롤 전체화면 막기
        }
        
        present(nextVC, animated: true)
    }
    
    func ipad() {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") else {
            return
        }

        
        if let sheet = nextVC.popoverPresentationController?.adaptiveSheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
    }
}


