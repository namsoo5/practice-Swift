//
//  ViewController.swift
//  prac_CoordinatorPattern
//
//  Created by 남수김 on 2020/05/16.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextVC(_ sender: Any) {
        coordinator?.showSecondVC()
    }
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var nav: UINavigationController
    
    init(nav: UINavigationController) {
        self.nav = nav
    }
    
    func start() {
        let vc = MainViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        nav.pushViewController(vc, animated: false)
    }
    
    func showSecondVC() {
        let vc = SecondViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }
}
