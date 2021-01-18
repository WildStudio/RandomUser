//
//  Cooridnates.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct Coordinates: Codable, Equatable {
    let latitude: String
    let longitude: String
}

extension Coordinates {
    init(coordinates: Models.Coordinates) {
        latitude = coordinates.latitude ?? ""
        longitude = coordinates.longitude ?? ""
    }
}

extension Models.Coordinates {
    var asCoordinates: Coordinates {
        Coordinates(coordinates: self)
    }
}


