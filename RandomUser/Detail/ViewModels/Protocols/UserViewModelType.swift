//
//  UserViewModelType.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import CoreLocation

protocol UserViewModelType {
    var profileImageURL: URL? { get }
    var email: String { get }
    var name: String { get }
    var gender: String { get }
    var registeredDate: String { get }
    var location: String { get }
    var locationCoordinate: CLLocationCoordinate2D? { get }
}
