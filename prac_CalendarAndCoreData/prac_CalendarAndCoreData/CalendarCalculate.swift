//
//  CalendarCalculate.swift
//  prac_CalendarAndCoreData
//
//  Created by 남수김 on 2020/07/25.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

class CalendarCalculate {
    var dayOfMonth: Int = 0
    var month: Int {
        didSet {
            dayOfMonth = getDayOfMonth()
            print(month)
        }
    }
    var year: Int {
        didSet {
            print(year)
        }
    }
    
    init() {
        year = Date().getYear()
        month = Date().getMonth()
        dayOfMonth = getDayOfMonth()
    }
    
    func getDayOfMonth() -> Int {
        switch self.month {
        case 1,3,5,7,8,10,12:
            return 31
        case 4,6,9,11:
            return 30
        case 2:
            if Date.isLeapYear(year) {
                return 29
            } else {
                return 28
            }
        default:
            return 0
        }
    }
    
    func nextMonth() {
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
    }
    
    func beforeMonth() {
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
    }
    
}

enum DayOfWeek: Int {
    case none = -1
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thr = 5
    case fri = 6
    case sat = 7
}

extension Date {
    private static func simpleDateFormatter() -> DateFormatter {
        let format = "yyyyMMdd"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter
    }
    // 월 시작요일 계산
    static func startWeekday(year: String, month: String) -> Int {
        let formatter = simpleDateFormatter()
        let dateString = "\(year)\(month)01"
        guard let date = formatter.date(from: dateString) else {
            return -1
        }
        let weekday = Calendar.current.component(.weekday, from: date)
        // sun:1 mon:2 tue:3 wed:4 thr:5 fri:6 sat:7
        return weekday
    }
    
    static func isLeapYear(_ year: Int) -> Bool {

        let isLeapYear = ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))

        return isLeapYear
    }
    
    func getMonth() -> Int {
        let month = Calendar.current.component(.month, from: Date())
        return month
    }
    
    func getYear() -> Int {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }
}
