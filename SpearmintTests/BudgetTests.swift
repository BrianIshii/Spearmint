//
//  BudgetTests.swift
//  SpearmintTests
//
//  Created by Brian Ishii on 6/19/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import XCTest
@testable import Spearmint

class BudgetTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBudgetMonth() {
        let budget = Budget(BudgetDate(Date()))
        
        XCTAssert(budget.month == DateFormatterFactory.MonthFormatter.string(from: Date()))
    }
    
    func testBudgetYear() {
        let budget = Budget(BudgetDate(Date()))
        
        XCTAssert(budget.year == DateFormatterFactory.YearFormatter.string(from: Date()))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
