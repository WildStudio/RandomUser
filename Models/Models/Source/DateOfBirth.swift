//
//  DateOfBirth.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct DateOfBirth: Codable {
    public let date: String?
    public let age: Int?
}

extension DateOfBirth: Equatable {
    
    public static func == (lhs: DateOfBirth, rhs: DateOfBirth) -> Bool {
        return lhs.date == rhs.date
            && lhs.age == rhs.age
    }
    
}
