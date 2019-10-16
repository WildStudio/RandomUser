//
//  Identifier.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct Identifier: Codable {
    public let name: String?
    public let value: String?
}

extension Identifier: Equatable {
    
    public static func == (lhs: Identifier, rhs: Identifier) -> Bool {
           return lhs.name == rhs.name
               && lhs.value == rhs.value
       }
    
}
