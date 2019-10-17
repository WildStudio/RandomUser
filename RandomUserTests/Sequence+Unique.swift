//
//  Sequence+Unique.swift
//  RandomUserTests
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import XCTest
@testable import RandomUser

class Sequence_Unique: XCTestCase {

    func testArrayWhenDuplicatedItemsReturnsArrayWithDuplicatedRemoved() {
        // Given
        let testSet: Set = [1,2,2,3]
        
        // When
        let uniques = testSet.uniqueElements
        
        // Then
        XCTAssertEqual(uniques.count, 3)
    }
    
}
