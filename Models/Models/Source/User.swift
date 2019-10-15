//
//  User.swift
//  Models
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct User {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: DateOfBirth?
    let registered: RegisteredData?
    let phone: String?
    let cell: String?
    let id: Identifier?
    let picture: ProfileImage?
    let nationality: String?
}

extension User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dob
        case registered
        case phone
        case cell
        case id
        case picture
        case nationality = "nat"
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.gender = try? container.decodeIfPresent(String.self, forKey: .gender)
        self.name = try? container.decodeIfPresent(Name.self, forKey: .name)
        self.location = try? container.decodeIfPresent(Location.self, forKey: .location)
        self.email = try container.decode(String.self, forKey: .email)
        self.login = try container.decode(Login.self, forKey: .login)
        self.dob = try container.decodeIfPresent(DateOfBirth.self, forKey: .dob)
        self.registered = try container.decodeIfPresent(RegisteredData.self, forKey: .registered)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.cell = try container.decodeIfPresent(String.self, forKey: .cell)
        self.id = try container.decode(Identifier.self, forKey: .id)
        self.picture = try container.decode(ProfileImage.self, forKey: .picture)
        self.nationality = try container.decode(String.self, forKey: .nationality)
        
    }
    
}


public struct Name: Codable {
    let title: String?
    let first: String?
    let last: String?
}

public struct Login: Codable {
    let uuid: String?
    let username: String?
    let password: String?
    let salt: String?
    let md5: String?
    let sha1: String?
    let sha256: String?
}


public struct DateOfBirth: Codable {
    let date: String?
    let age: Int?
}


public struct RegisteredData: Codable {
    let date: String?
    let age: Int?
}


public struct Identifier: Codable {
    let name: String?
    let value: String?
}


public struct ProfileImage: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}


