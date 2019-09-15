//
//  ContainerTests.swift
//  SpearmintTests
//
//  Created by Brian Ishii on 9/7/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import XCTest
import Spearmint

class ContainerTests: XCTestCase {
    var sut: Container!
    
    override func setUp() {
        super.setUp()
        sut = Container()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRegisterAndResolveSingleton() {
        let service = LocalPersistanceService()

        sut.registerSingleton(service as LocalPersistance)
        let resolvedService = sut.resolve(LocalPersistance.self) as? LocalPersistanceService
        
        XCTAssertNotNil(resolvedService)
        XCTAssert(service === resolvedService)
    }
    
    func testContainerReturnsNilWithNonRegisteredService() {
        XCTAssertNil(sut.resolve(LocalPersistanceService.self))
    }
    
    func testFatalErrorWhenRegisteringSingletonTwoTimes() {
        let service = LocalPersistanceService()

        sut.registerSingleton(service as LocalPersistance)

        //TODO: Fatal error tests
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
