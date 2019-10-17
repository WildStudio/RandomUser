//
//  UserViewModel.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models
import CoreLocation

class UserViewModel: UserViewModelType {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var profileImageURL: URL? {
        guard let imageURLString = user.picture?.large
            else { return nil }
        return URL(string: imageURLString)
    }
    
    var email: String {
        user.email ?? .init()
    }
    
    var name: String {
        "\(user.name?.first ?? .init()) \(user.name?.last ?? .init())"
    }
    
    var gender: String {
        user.gender ?? .init()
    }
    
    var registeredDate: String {
        user.registered?.date ?? .init()
    }
    
    var location: String {
        let street = user.location?.street
        let city = user.location?.city
        let state = user.location?.state
        
        return "\(street ?? .init()) \(city ?? .init()) \(state ?? .init())"
        
    }
    
    var locationCoordinate: CLLocationCoordinate2D? {
        guard let latitude = Double(user.location?.coordinates?.latitude ?? .init()),
            let longitude = Double(user.location?.coordinates?.longitude ?? .init())
            else { return nil }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}

