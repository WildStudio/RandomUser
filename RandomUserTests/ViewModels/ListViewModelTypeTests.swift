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

    var viewModel: ListViewModelType!
    var repository: RandomUsersRepositoryType!
    
    
    override func setUp() {
        super.setUp()
        repository = RandomUsersRepository(
            service: MockRandomUserService(
                serverConfig: MockServerConfig()
            ), cacheService: CacheService()
        )
        viewModel = ListViewModel(repository: repository)
    }
    
    
    func tesUserIsInsertedInUsersList() {
        // Given, When
        viewModel.handleResult(.success([MockConstant.user]))
        
        // Then
        XCTAssertEqual(viewModel.users.count, 1)
    }

    
    func testUserIsRemovedAndNotInsertedIfIsBlacklisted() {
        // Given
        viewModel.handleResult(.success([MockConstant.user]))
        
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.blacklist.count, 0)
        
        // When
        viewModel.remove(user: MockConstant.user, at: 0)
        viewModel.handleResult(.success([MockConstant.user]))
        
        // Then
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertEqual(viewModel.blacklist.count, 1)
    }

}
