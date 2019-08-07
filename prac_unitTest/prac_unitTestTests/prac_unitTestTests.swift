//
//  prac_unitTestTests.swift
//  prac_unitTestTests
//
//  Created by 남수김 on 06/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import XCTest
@testable import prac_unitTest

class prac_unitTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testVanillaLeapYear() {
        
        let year = Year(calendarYear: 1996)
        XCTAssertTrue(year.isLeapYear)
        
    }
    
    
    
    
    func testAnyOldYear() {
        
        let year = Year(calendarYear: 1997)
        
        XCTAssertTrue(!year.isLeapYear)
        
    }
    
    
    
    func testCentury() {
        
        let year = Year(calendarYear: 1900)
        
        XCTAssertTrue(!year.isLeapYear)
        
    }
    
    
    
    func testExceptionalCentury() {
        
        let year = Year(calendarYear: 2400)
        
        XCTAssertTrue(year.isLeapYear)
        
    }
    
}
