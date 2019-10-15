//
//  HomeViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 14/10/2019.
//  Copyright © 2019 adevinta. All rights reserved.
//

import UIKit
import Models
import SDWebImage
import RandomUserKit

class HomeViewController: UIViewController {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
        static let none = "Empty Field"
    }
    
    @IBOutlet private var tableView: UITableView!
    
    private var emptyStateController: EmptyStateViewController?
    private var viewModel: HomeViewModel?
    
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
        cell.textLabel?.text = "\(user.name?.first ?? Constant.none) \(user.name?.last ?? Constant.none)"
        
        if let thumbnail = user.picture?.thumbnail,
            let imageURL = URL(string: thumbnail) {
            cell.imageView?.sd_setImage(with: imageURL)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            viewModel?.removeUser(at: indexPath.row)
        }
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
    func deletedItem(at index: Int, users: [User]) {
        tableView.beginUpdates()
        self.users = users
        tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
        tableView.endUpdates()
    }
    
    
    func viewModelFetched(users: [User]) {
        self.users = users
    }
    
}

extension HomeViewController: EmptyStateViewControllerDelegate {
    
    func emptyStatesViewControllerTappedMainButton() {
        viewModel?.performFetching()
    }
    
}

