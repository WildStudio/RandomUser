//
//  ThumbnailCellViewModel.swift
//  RandomUser
//
//  Created by wearemobilefirst on 20/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import Foundation
import Models

final class ThumbnailCellViewModel {
    
    private enum Constant {
        static let none = "Empty Field"
    }
    
    private let user: User
    
    
    init(_ user: User) {
        self.user = user
    }
    
    
    var profileImageURL: URL? {
        if let thumbnail = user.picture?.thumbnail {
            return URL(string: thumbnail)
        }
        
        return nil
    }
    
    
    var textLabel: String {
        "\(user.name?.first ?? Constant.none) \(user.name?.last ?? Constant.none)"
    }
    
    
    var detailLabel: String {
        "\(user.email ?? Constant.none) \(user.phone ?? Constant.none)"
    }
    
}

