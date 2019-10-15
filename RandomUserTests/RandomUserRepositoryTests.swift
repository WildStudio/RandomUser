//
//  RandomUserRepositoryTests.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

@testable import RandomUser
import XCTest

class RandomUserRepositoryTests: XCTestCase {
    
    var repository: RandomUsersRepositoryType!
    
    override func setUp() {
        super.setUp()
        repository = RandomUsersRepository(
            service: MockRandomUserService(
                serverConfig: MockServerConfig()
            )
        )
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    // MARK: Fetch user
    
    func testFetchReturnsUseRresult() {
        repository.fetch { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
}
