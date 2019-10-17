//
//  DetailViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 17/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class DetailViewController: UIViewController {
    
    private enum Constant {
        static let placeholderImage = "avatar-image"
    }
    
    private var viewModel: UserViewModelType?
    
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var registeredDateLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    
    
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
        
        if let coordinate = viewModel?.locationCoordinate {
            mapView.addAnnotation(Marker(coordinate: coordinate))
        }
    }
    
}
