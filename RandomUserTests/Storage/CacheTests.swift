//
//  CacheTests.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

@testable import RandomUser
import XCTest

class CacheTests: XCTestCase {

    var cache: Cache!
    
    override func setUp() {
        super.setUp()
        cache = Cache()
    }

    override func tearDown() {
        cache = nil
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
