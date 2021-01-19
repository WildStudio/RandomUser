//
//  Login.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct Login: Codable, Equatable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}


extension Login {
    init(login: Models.Login) {
        uuid = login.uuid ?? ""
        username = login.username ?? ""
        password = login.password ?? ""
        salt = login.salt ?? ""
        md5 = login.md5 ?? ""
        sha1 = login.sha1 ?? ""
        sha256 = login.sha256 ?? ""
    }
}

extension Models.Login {
    var asLogin: Login {
        Login(login: self)
    }
}
