//
//  Location.swift
//  RandomUser
//
//  Created by Christian Aranda on 17/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
    let coordinates: Coordinates?
    let timezone: TimeZone?
}

extension Location {
    init(location: Models.Location) {
        street = location.street ?? ""
        city = location.city ?? ""
        state = location.state ?? ""
        postcode = location.postcode ?? ""
        coordinates = location.coordinates.map { $0.asCoordinates }
        timezone = location.timezone.map { $0.asTimeZone }
    }
}

extension Models.Location {
    var asLocation: Location {
        Location(location: self)
    }
}

extension Location: Equatable {
    
    public static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.street == rhs.street
        && lhs.city == rhs.city
        && lhs.state == rhs.state
        && lhs.postcode == rhs.postcode
        && lhs.coordinates == rhs.coordinates
        && lhs.timezone == rhs.timezone
    }
    
}

