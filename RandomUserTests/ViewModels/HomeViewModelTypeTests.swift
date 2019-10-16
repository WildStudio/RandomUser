//
//  HomeViewModelTypeTests.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import XCTest
@testable import RandomUser

class HomeViewModelTypeTests: XCTestCase {

    var viewModel: HomeViewModelType!
    var repository: RandomUsersRepositoryType!
    
    
    override func setUp() {
        super.setUp()
        repository = RandomUsersRepository(
            service: MockRandomUserService(
                serverConfig: MockServerConfig()
            )
        )
        viewModel = HomeViewModel(repository: repository)
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
        
        // When
        if viewModel.insertBlacklisted(MockConstant.user) {
              viewModel.handleResult(.success([MockConstant.user]))
        } else {
            XCTFail("Unable to insert usr in the blacklist, please fix it")
        }
        
        // Then
        XCTAssertEqual(viewModel.users.count, 0)
    }

}
