//
//  UserViewModelTypeTests.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import XCTest
@testable import RandomUser

class UserViewModelTypeTests: XCTestCase {
    
    var viewModel: UserViewModelType!
    
    
    override func setUp() {
        super.setUp()
        let user = MockConstant.user.asUser
        viewModel = UserViewModel(user: user)
    }
    
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    
    func testViewModelUserDataIsCorrect() {
        
        // Given
        let user = MockConstant.user
        
        // When
        let expectedEmail = user.email
        let expectedName = "\(user.name?.first ?? .init()) \(user.name?.last ?? .init())"
        let expectedGender = user.gender
        let expectedRegisteredDate = user.registered?.date
        
        // Then
        XCTAssertEqual(viewModel.email, expectedEmail)
        XCTAssertEqual(viewModel.name, expectedName)
        XCTAssertEqual(viewModel.gender, expectedGender)
        XCTAssertEqual(viewModel.registeredDate, expectedRegisteredDate)
    }
    
}
