//
//  Name.swift
//  RandomUser
//
//  Created by Christian Aranda on 17/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct Name: Codable, Equatable {
    let title: String
    let first: String
    let last: String
}

extension Name {
    init(name: Models.Name) {
        title = name.title ?? ""
        first = name.first ?? ""
        last = name.last ?? ""
    }
}

extension Models.Name {
    var asName: Name {
        Name(name: self)
    }
}
