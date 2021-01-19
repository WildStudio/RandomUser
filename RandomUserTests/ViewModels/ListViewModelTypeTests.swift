//
//  ListViewModelTypeTests.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import XCTest
@testable import RandomUser

class ListViewModelTypeTests: XCTestCase {

    var sut: ListViewModel!
    var repository: RandomUsersRepositoryType!
    
    
    override func setUp() {
        super.setUp()
        repository = RandomUsersRepository(
            service: MockRandomUserService(
                serverConfig: MockServerConfig()
            ), cacheService: CacheService()
        )
        sut = ListViewModel(repository: repository)
    }
    
    
    func tesUserIsInsertedInUsersList() {
        // Given, When
        sut.handleResult(
            .success([MockConstant.user].map { $0.asUser })
        )
        
        // Then
        XCTAssertEqual(sut.users.count, 1)
    }

    
    func testUserIsRemovedAndNotInsertedIfIsBlacklisted() {
        // Given
        sut.handleResult(
            .success([MockConstant.user].map { $0.asUser })
        )
        
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertEqual(sut.blacklist.count, 0)
        
        // When
        sut.remove(user: MockConstant.user.asUser, at: 0)
        sut.handleResult(
            .success([MockConstant.user].map { $0.asUser })
        )
        
        // Then
        XCTAssertEqual(sut.users.count, 0)
        XCTAssertEqual(sut.blacklist.count, 1)
    }

}
