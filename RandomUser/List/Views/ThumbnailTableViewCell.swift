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

final class ThumbnailTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let none = "Empty Field"
        static let placeholderImage = "avatar-image"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    
    func configure(with user: User?) {
        guard let user = user else { return }
        textLabel?.text = "\(user.name?.first ?? Constant.none) \(user.name?.last ?? Constant.none)"
        
        imageView?.image = UIImage(named: Constant.placeholderImage)
        if let thumbnail = user.picture?.thumbnail,
            let imageURL = URL(string: thumbnail) {
            imageView?.sd_setImage(with: imageURL)
        }
        
        accessoryType = .disclosureIndicator
    }
}
