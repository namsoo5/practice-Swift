//
//  Coordinator.swift
//  prac_CoordinatorPattern
//
//  Created by 남수김 on 2020/05/17.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var nav: UINavigationController { get set }
    
    func start()
}
