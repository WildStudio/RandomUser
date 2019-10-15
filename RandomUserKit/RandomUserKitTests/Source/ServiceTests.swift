//
//  ServiceTests.swift
//  RandomUserKitTests
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import RandomUserKit
import Models
import XCTest

final class ServiceTests: XCTestCase {
    
    private enum Constant {
        static let fielName = "randomusers"
        static let fileExtension = "json"
        static let results = "results"
    }
    
    func testLoadData_FromLocalJsonFile() {
        guard let url = Bundle(
            for: ServiceTypeTests.self)
            .url(
                forResource: Constant.fielName,
                withExtension: Constant.fileExtension
            ),
            let data = try? Data(contentsOf: url),
             let users = JSON.decodeModels(Constant.results, data) as [User]?
            else {
                XCTFail("No data was loaded.")
                return
        }
        
        XCTAssertNotNil(users)
    }
    
}

