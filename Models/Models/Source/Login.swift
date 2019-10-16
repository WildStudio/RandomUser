//
//  Login.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct Login: Codable {
    public let uuid: String?
    public let username: String?
    public let password: String?
    public let salt: String?
    public let md5: String?
    public let sha1: String?
    public let sha256: String?
}

extension Login: Equatable {
    
    public static func == (lhs: Login, rhs: Login) -> Bool {
        return lhs.uuid == rhs.uuid
            && lhs.username == rhs.username
            && lhs.password == rhs.password
            && lhs.salt == rhs.salt
            && lhs.md5 == rhs.md5
            && lhs.sha1 == rhs.sha1
            && lhs.sha256 == rhs.sha256
    }
    
}
