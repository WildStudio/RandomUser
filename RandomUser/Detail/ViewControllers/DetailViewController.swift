//
//  DetailViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    private enum Constant {
        static let placeholderImage = "avatar-image"
        static let storyboard = "Main"
        static let identifier = "DetailViewController"
    }
    
    private var viewModel: UserViewModelType?
    
    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var registeredDateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    
    func configure(with viewModel: UserViewModelType) {
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        nameLabel.text = viewModel?.name
        genderLabel.text = viewModel?.gender
        emailLabel.text = viewModel?.email
        registeredDateLabel.text = viewModel?.registeredDate
        locationLabel.text = viewModel?.location
        profileImageView.image = UIImage(named: Constant.placeholderImage)
        
        if let profileImageURL = viewModel?.profileImageURL {
            profileImageView?.sd_setImage(with: profileImageURL)
        }
        
        if let headerImageURL = viewModel?.headerImageURL {
            profileImageView?.sd_setImage(with: headerImageURL)
        }
        
    }
    
}


extension DetailViewController {
    
    static func instantiate() -> DetailViewController? {
        let storyboard = UIStoryboard(name: DetailViewController.Constant.storyboard, bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: Constant.identifier) as? DetailViewController
            else { return nil }
        
        return viewController
    }
    
}
