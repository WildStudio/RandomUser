//
//  TimeZone.swift
//  Models
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct TimeZone: Codable {
    public let offset: String?
    public let description: String?
}

extension TimeZone: Equatable {
    
    public static func == (lhs: TimeZone, rhs: TimeZone) -> Bool {
        return lhs.offset == rhs.offset
        && lhs.description == rhs.description
    }
    
}
