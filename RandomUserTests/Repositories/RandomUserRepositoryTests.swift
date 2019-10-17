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
            ), cacheService: CacheService()
        )
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    // MARK: Fetch single user
    
    func testFetchReturnsSingleResult() {
        repository.fetch(results: 1) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
    
    // MARK: Fetch list of users
    
    func testFetchReturnsResults(number: Int = 10) {
        repository.fetch(results: number) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, number)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
    
}
