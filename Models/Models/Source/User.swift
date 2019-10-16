//
//  User.swift
//  Models
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct User {
    public let gender: String?
    public let name: Name?
    public let location: Location?
    public let email: String?
    public let login: Login?
    public let dob: DateOfBirth?
    public let registered: RegisteredData?
    public let phone: String?
    public let cell: String?
    public let id: Identifier?
    public let picture: ProfileImage?
    public let nationality: String?
    
    public var userUUID: UUID? {
        guard let login = login,
            let loginID = login.uuid,
            let uuid = UUID(uuidString: loginID)
            else {
                return nil
        }
        return uuid
    }
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
    public let title: String?
    public let first: String?
    public let last: String?
}

public struct Login: Codable {
    public let uuid: String?
    public let username: String?
    public let password: String?
    public let salt: String?
    public let md5: String?
    public let sha1: String?
    public let sha256: String?
}


public struct DateOfBirth: Codable {
    public let date: String?
    public let age: Int?
}


public struct RegisteredData: Codable {
    public let date: String?
    public let age: Int?
}


public struct Identifier: Codable {
    public let name: String?
    public let value: String?
}


public struct ProfileImage: Codable {
    public let large: String?
    public let medium: String?
    public let thumbnail: String?
}


