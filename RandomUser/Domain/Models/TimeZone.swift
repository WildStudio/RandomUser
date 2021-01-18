//
//  TimeZone.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct TimeZone: Codable, Equatable {
    let offset: String
    let description: String
}

extension TimeZone {
    init(timeZone: Models.TimeZone) {
        offset = timeZone.offset ?? ""
        description = timeZone.description ?? ""
    }
}

extension Models.TimeZone {
    var asTimeZone: TimeZone {
        TimeZone(timeZone: self)
    }
}
