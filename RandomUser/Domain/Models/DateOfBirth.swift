//
//  DateOfBirth.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct DateOfBirth: Codable, Equatable {
    let date: String
    let age: Int?
}

extension DateOfBirth {
    init(dateOfBirth: Models.DateOfBirth) {
        date = dateOfBirth.date ?? ""
        age = dateOfBirth.age
    }
}

extension Models.DateOfBirth {
    var asDateOfBirth: DateOfBirth {
        DateOfBirth(dateOfBirth: self)
    }
}
