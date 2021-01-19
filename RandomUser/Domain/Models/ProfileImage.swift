//
//  ProfileImage.swift
//  RandomUser
//
//  Created by Christian Aranda on 18/01/2021.
//  Copyright © 2021 adevinta. All rights reserved.
//

import Foundation
import Models

struct ProfileImage: Codable, Equatable {
    let large: String
    let medium: String
    let thumbnail: String
}

extension ProfileImage {
    init(profileImage: Models.ProfileImage) {
        large = profileImage.large ?? ""
        medium = profileImage.medium ?? ""
        thumbnail = profileImage.thumbnail ?? ""
    }
}

extension Models.ProfileImage {
    var asProfileImage: ProfileImage {
        ProfileImage(profileImage: self)
    }
}
