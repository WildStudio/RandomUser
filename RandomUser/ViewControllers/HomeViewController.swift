//
//  HomeViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import RandomUserKit

class HomeViewController: UIViewController {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
    }
    
    @IBOutlet private var tableView: UITableView!
    
    private var emptyStateController: EmptyStateViewController?
    var viewModel: HomeViewModel?
    
    private var users: [User] = [] {
        didSet { tableView.reloadData() }
    }
    
    lazy var emptyCell = UITableViewCell()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.delegate = self
        viewModel?.performFetching()
        title = viewModel?.title
    }
    
    
    func configure(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellReuseIdentifier)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emptyStateController?.view.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReuseIdentifier)
            else { return emptyCell }
        
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name?.first ?? "emptyField") \(user.name?.last ?? "emptyField")"
        return cell
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
    func viewModelFetched(users: [User]) {
        self.users = users
    }
    
}

extension HomeViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        viewModel?.performFetching()
    }
    
}

