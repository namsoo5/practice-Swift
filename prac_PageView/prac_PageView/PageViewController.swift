//
//  PageViewController.swift
//  prac_PageView
//
//  Created by 남수김 on 13/03/2019.
//  Copyright © 2019 Charang. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //넘길 페이지 viewcontroller
    lazy var subViewController: [UIViewController] = {
       return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController1") as! ViewController1,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3]
    }()
    
    //전페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let curindex:Int = subViewController.firstIndex(of: viewController) ?? 0
        if curindex <= 0 {
            return nil
        }
        return subViewController[curindex-1]
        //nil 일경우 넘어가지않음
    }
    
    //뒤페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      
        let curindex:Int = subViewController.firstIndex(of: viewController) ?? 0
        if curindex >= subViewController.count-1 {
            return nil
        }
        return subViewController[curindex+1]
    }
    
    //페이지수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for ges in self.gestureRecognizers{
            ges.cancelsTouchesInView = true
        }
        
        for view in self.view.subviews{
            (view as! UIScrollView).isScrollEnabled = false
        }
        self.delegate = self
        self.dataSource = self
        //페이지달아주기
        self.setViewControllers([subViewController[0]], direction: .forward, animated: false, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func nextpage() {
        <#function body#>
    }

}
