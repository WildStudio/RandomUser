//
//  ThumbnailTableViewCell.swift
//  RandomUser
//
//  Created by wearemobilefirst on 16/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import SDWebImage

class ThumbnailTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let none = "Empty Field"
    }
    
    func configure(with user: User) {
        textLabel?.text = "\(user.name?.first ?? Constant.none) \(user.name?.last ?? Constant.none)"
        
        if let thumbnail = user.picture?.thumbnail,
            let imageURL = URL(string: thumbnail) {
            imageView?.sd_setImage(with: imageURL)
        }
    }
}
