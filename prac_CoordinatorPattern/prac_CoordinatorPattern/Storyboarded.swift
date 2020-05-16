//
//  Storyboarded.swift
//  prac_CoordinatorPattern
//
//  Created by 남수김 on 2020/05/17.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
