//
//  File.swift
//  prac_unitTest
//
//  Created by 남수김 on 06/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation


struct Year {
    let calendarYear: Int
    var isLeapYear: Bool { get {
        return calendarYear%4 == 0 && ( calendarYear%100 != 0 || calendarYear%400 == 0)
        }
    }
}
