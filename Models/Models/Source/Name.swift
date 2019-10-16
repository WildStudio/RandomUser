//
//  Name.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct Name: Codable {
    public let title: String?
    public let first: String?
    public let last: String?
}

extension Name: Equatable {
    public static func == (lhs: Name, rhs: Name) -> Bool {
        return lhs.title == rhs.title
        && lhs.first == rhs.first
        && lhs.last == rhs.last
    }
}
