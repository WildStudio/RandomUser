//
//  ServiceTypeTests.swift
//  RandomUserKitTests
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import RandomUserKit
import Models
import XCTest

final class ServiceTypeTests: XCTestCase {
    
    private enum Constant {
        static let timeout = 10.0
        static let resultsNumber = 10
    }
    
    var serverConfig: ServerConfigType!
    var service: ServiceType!


    override func setUp() {
        serverConfig = MockServerConfig()
        service = Service(serverConfig: serverConfig)
    }

    func testDownloadUsersData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download randomusers.me/api")

        // Create a background task to download the data
        service.fetchUsers(results: nil) { users, _ in
            // Make sure we downloaded some data.
            XCTAssertNotNil(users, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: Constant.timeout)
    }
    
    func testDownloadConcreteUsersData() {
        let expectation = XCTestExpectation(description: "Download 10 users from randomusers.me/api")
        var data: [User]?
        service.fetchUsers(results: Constant.resultsNumber) { users, _ in
            data = users
            XCTAssertNotNil(users, "No data was downloaded.")
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: Constant.timeout)
        XCTAssertEqual(Constant.resultsNumber, data?.count)
    }
    
}
