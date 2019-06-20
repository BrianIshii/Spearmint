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
    
    func testBudgetDateString() {
        let budget = Budget(date: "Jun 2019", items: BudgetItem.defaultBudgetItems())
        
        XCTAssert(budget.dateString == "Jun 2019")
    }
    
    func testBudgetMonth() {
        let budget = Budget(date: "Jun 2019", items: BudgetItem.defaultBudgetItems())
        
        XCTAssert(budget.month == "June")
    }
    
    func testBudgetYear() {
        let budget = Budget(date: "Jun 2019", items: BudgetItem.defaultBudgetItems())
        
        XCTAssert(budget.year == "2019")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
