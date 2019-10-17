//
//  EmptyStatesViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 15/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit

protocol EmptyStateViewControllerDelegate: AnyObject {
  func emptyStatesViewControllerTappedMainButton()
}

final class EmptyStateViewController: UIViewController {

    @IBOutlet private var mainButton: UIButton!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    
    weak var delegate: EmptyStateViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView() {
        titleLabel.text = "Welcome to the best random users App"
        subtitleLabel.text = "What are you waiting for? Start using the ranomizer app."
        mainButton.setTitle("Start", for: .normal)
    }
    
    
    @IBAction private func didTapMainActionButton(_ sender: Any) {
        delegate?.emptyStatesViewControllerTappedMainButton()
    }
    
}
