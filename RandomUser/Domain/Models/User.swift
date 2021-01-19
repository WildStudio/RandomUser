//
//  User.swift
//  RandomUser
//
//  Created by Christian Aranda on 17/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct User: Codable, Equatable {
    
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: DateOfBirth?
    let registered: RegisteredData?
    let phone: String?
    let cell: String?
    let id: UserIdentifier?
    let picture: ProfileImage?
    let nationality: String?
    
    public var userUUID: UUID? {
        guard let login = login,
            let uuid = UUID(uuidString: login.uuid)
            else {
                return nil
        }
        return uuid
    }
    
}

extension User {
    init(user: Models.User) {
        gender = user.gender
        name = user.name.map { $0.asName }
        location = user.location.map { $0.asLocation }
        email = user.email
        login = user.login.map { $0.asLogin }
        dob = user.dob.map { $0.asDateOfBirth }
        registered = user.registered.map{ $0.asRegisteredData }
        phone = user.phone
        cell = user.cell
        id = user.id.map  { $0.asUserIdentifier }
        picture = user.picture.map { $0.asProfileImage }
        nationality =  user.nationality
    }
}

extension Models.User {
    var asUser: User {
        User(user: self)
    }
}

extension User: Hashable {
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.gender == rhs.gender
        && lhs.name == rhs.name
        && lhs.location == rhs.location
        && lhs.login == rhs.login
        && lhs.dob == rhs.dob
        && lhs.registered == rhs.registered
        && lhs.phone == rhs.phone
        && lhs.cell == rhs.cell
        && lhs.id == rhs.id
        && lhs.picture == rhs.picture
        && lhs.nationality == rhs.nationality
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(userUUID)
    }
    
}

