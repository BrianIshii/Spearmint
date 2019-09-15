//
//  CurrentTests.swift
//  SpearmintTests
//
//  Created by Brian Ishii on 5/18/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import XCTest
@testable import Spearmint

class CurrenyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOneDollar() {
        XCTAssert(CurrencyOld.currencyToFloat("$1.00") == 1)
        XCTAssert(CurrencyOld.currencyFormatter("1.00") == "$1.00")
    }
    
    func testOneDollarNinetyNineCents() {
        XCTAssert(CurrencyOld.currencyToFloat("$1.99") == 1.99)
        XCTAssert(CurrencyOld.currencyFormatter("1.99") == "$1.99")
    }
    
    func testTwentyDollars() {
        XCTAssert(CurrencyOld.currencyToFloat("$20.00") == 20.0)
        XCTAssert(CurrencyOld.currencyFormatter("20.00") == "$20.00")

    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
