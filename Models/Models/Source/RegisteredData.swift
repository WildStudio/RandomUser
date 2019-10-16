//
//  RegisteredData.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation


public struct RegisteredData: Codable {
    public let date: String?
    public let age: Int?
}

extension RegisteredData: Equatable {
    
    public static func == (lhs: RegisteredData, rhs: RegisteredData) -> Bool {
        return lhs.date == rhs.date
            && lhs.age == rhs.age
    }
}
