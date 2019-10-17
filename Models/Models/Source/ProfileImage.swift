//
//  ProfileImage.swift
//  Models
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation

public struct ProfileImage: Codable {
    public let large: String?
    public let medium: String?
    public let thumbnail: String?
}


extension ProfileImage: Equatable {
    
    public static func == (lhs: ProfileImage, rhs: ProfileImage) -> Bool {
        return lhs.large == rhs.large
            && lhs.medium == rhs.medium
            && lhs.thumbnail == rhs.thumbnail
    }
    
}
