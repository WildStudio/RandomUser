//
//  RegisteredData.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct RegisteredData: Codable, Equatable {
    let date: String
    let age: Int?
}

extension RegisteredData {
    init(data: Models.RegisteredData) {
        date = data.date ?? ""
        age = data.age
    }
}

extension Models.RegisteredData {
    var asRegisteredData: RegisteredData {
        RegisteredData(data: self)
    }
}
