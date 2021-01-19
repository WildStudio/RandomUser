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
        static let placeholderImage = "avatar-image"
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func configure(with viewModel: ThumbnailCellViewModel?) {
        textLabel?.text = viewModel?.textLabel
        detailTextLabel?.text = viewModel?.detailLabel
        imageView?.image = UIImage(named: Constant.placeholderImage)
        
        if let imageURL = viewModel?.profileImageURL {
            imageView?.sd_setImage(with: imageURL)
        }
        
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
}
