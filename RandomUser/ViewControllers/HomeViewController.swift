//
//  HomeViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    private var emptyStateController: EmptyStateViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emptyStateController = EmptyStateViewController()
        self.emptyStateController = emptyStateController
        emptyStateController.delegate = self
        addChild(emptyStateController)
        view.addSubview(emptyStateController.view)
        emptyStateController.didMove(toParent: self)
 
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      self.emptyStateController?.view.frame = self.view.bounds
    }

}

extension HomeViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        print("Tapped main button")
    }

}

