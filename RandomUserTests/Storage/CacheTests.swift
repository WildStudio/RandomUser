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

    var cache: CacheService!
    
    override func setUp() {
        super.setUp()
        cache = CacheService()
    }

    override func tearDown() {
        cache = nil
        super.tearDown()
    }

    
    func testFileIsCached() {
        // Given, When
        try? cache.saveToDisk(users: [MockConstant.user])
        
        // Then
        XCTAssertTrue(cache.isFilePersisted())
    }

    
    func testFileIsLoadedAndUsersArePresent() {
        // Given
        try? cache.saveToDisk(users: [MockConstant.user])
        
        // When
        let users = try? cache.loadFromDisk()
        
        // Then
        XCTAssertEqual(users?.count, 1)
    }
    
    
    func testFileIsRemovedFromCache() {
        // Given
        try? cache.saveToDisk(users: [MockConstant.user])
        
        // When
        let users = try? cache.loadFromDisk()
        
        // Then
        XCTAssertEqual(users?.count, 1)
    }
    
}
