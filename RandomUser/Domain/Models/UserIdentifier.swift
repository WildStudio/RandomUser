//
//  Identifier.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct UserIdentifier: Codable, Equatable {
    let name: String
    let value: String
}

extension UserIdentifier {
    init(identifier: Models.Identifier) {
        name = identifier.name ?? ""
        value = identifier.value ?? ""
    }
}

extension Models.Identifier {
    var asUserIdentifier: UserIdentifier {
        UserIdentifier(identifier: self)
    }
}
