//
//  Location.swift
//  Models
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation


public struct Location {
    let street: String
    let city: String
    let state: String
    let postcode: String
    let coordinates: Coordinates?
    let timezone: TimeZone?
}

extension Location: Codable {
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case postcode
        case coordinates
        case timezone
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        street = try container.decodeIfPresent(String.self, forKey: .street) ?? .init()
        city = try container.decodeIfPresent(String.self, forKey: .city) ?? .init()
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? .init()
        postcode = try container.decodeIfPresent(String.self, forKey: .postcode) ?? .init()
        coordinates = try? container.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        timezone = try? container.decodeIfPresent(TimeZone.self, forKey: .timezone)
    }
}
